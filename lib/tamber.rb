# Tamber Ruby bindings
# API spec at https://tamber.com/docs/api
require 'cgi'
require 'openssl'
require 'rbconfig'
require 'set'
require 'socket'
require 'base64'

require 'rest-client'
require 'json'

require 'tamber/version'

require 'tamber/api_operations/create'
require 'tamber/api_operations/update'
require 'tamber/api_operations/remove'
require 'tamber/api_operations/retrieve'
require 'tamber/api_operations/request'

require 'tamber/tamber_object'
require 'tamber/util'
require 'tamber/api_resource'
require 'tamber/discover'
require 'tamber/event'
require 'tamber/user'
require 'tamber/item'
require 'tamber/behavior'


require 'tamber/tamber_error'


module Tamber
  DEFAULT_CA_BUNDLE_PATH = File.dirname(__FILE__) + '/security/ca-bundle.crt'

  @ca_bundle_path  = DEFAULT_CA_BUNDLE_PATH
  @verify_ssl_certs = true

  @api_url = 'https://api.tamber.com/v1'
  @open_timeout = 30
  @read_timeout = 80

  class << self
    attr_accessor :api_key, :api_url, :api_base, :api_version, :verify_ssl_certs, :open_timeout, :read_timeout
  end


  def self.api_url(api_base_url=nil, url='')
    (api_base_url || @api_url) + url
  end

  def self.ca_bundle_path
    @ca_bundle_path
  end

  def self.ca_bundle_path=(path)
    @ca_bundle_path = path
  end

  def self.request(method, url, params={})
    api_base_url = api_base_url || @api_base

    unless api_key ||= @api_key
      raise TamberError.new('No API key provided. ' \
                            'Set your engine-specific API key using "Tamber.api_key = <ENGINE-API-KEY>". ' \
                            'You can get your engine\'s api key from the Tamber dashboard. ' \
                            'See https://dashboard.tamber.com to get your engine\'s key, or ' \
                            'email support@tamber.com if you have any questions.)')
    end

    if api_key =~ /\s/
      raise TamberError.new('Your API key is invalid, as it contains ' \
                            'whitespace. (HINT: You can double-check your API key from the ' \
                            'Tamber dashboard. See https://dashboard.tamber.com to get your engine\'s key, or ' \
                            'email support@tamber.com if you have any questions.)')
    end

    if verify_ssl_certs
      request_opts = {:verify_ssl => OpenSSL::SSL::VERIFY_PEER,
                      :ssl_ca_file => @ca_bundle_path}
    else
      request_opts = {:verify_ssl => false}
      unless @verify_ssl_warned
        @verify_ssl_warned = true
        $stderr.puts("WARNING: Running without SSL cert verification. " \
                     "You should never do this in production. " \
                     "Execute 'Tamber.verify_ssl_certs = true' to enable verification.")
      end
    end

    # params = Util.objects_to_ids(params)
    url = api_url(api_base_url,url)

    case method.to_s.downcase.to_sym
    when :get, :head, :delete
      # Make params into GET parameters
      url += "#{URI.parse(url).query ? '&' : '?'}#{Util.encode_parameters(params)}" if params && params.any?
      payload = nil
    else
      payload = Util.encode_parameters(params)
    end

    request_opts.update(:headers => request_headers(api_key, method),
                        :method => method, :open_timeout => open_timeout,
                        :payload => payload, :url => url, :timeout => read_timeout)

    response = execute_request_with_rescues(request_opts, api_base_url)

    [parse(response)]
  end



  def self.request_headers(api_key, method)
    encoded_key  = Base64.encode64(api_key + ':')
    headers = {
      :user_agent => "Tamber/v1 RubyBindings/#{Tamber::VERSION}",
      :authorization => "Basic "+encoded_key,
      :content_type => 'application/x-www-form-urlencoded'
    }

    headers[:tamber_version] = api_version if api_version

    begin
      headers.update(:x_tamber_client_user_agent => JSON.generate(user_agent))
    rescue => e
      headers.update(:x_tamber_client_raw_user_agent => user_agent.inspect,
                     :error => "#{e} (#{e.class})")
    end
  end

  def self.user_agent
    lang_version = "#{RUBY_VERSION} p#{RUBY_PATCHLEVEL} (#{RUBY_RELEASE_DATE})"

    {
      :bindings_version => Tamber::VERSION,
      :lang => 'ruby',
      :lang_version => lang_version,
      :platform => RUBY_PLATFORM,
      :engine => defined?(RUBY_ENGINE) ? RUBY_ENGINE : '',
      :publisher => 'tamber',
      :hostname => Socket.gethostname,
    }

  end

  def self.general_api_error(rbody)
    TamberError.new("Invalid response object from API: "+rbody.inspect)
  end

  def self.execute_request(opts)
    RestClient::Request.execute(opts)
  end

  def self.parse(response)
    begin
      response = JSON.parse(response.body)
      if response["success"]
        response = response["result"]
      else
        raise TamberError.new("Error: "+response["error"])
      end
    rescue JSON::ParserError
      raise general_api_error(response.body)
    end

    Util.symbolize_names(response)
  end

  private

  def self.execute_request_with_rescues(request_opts, api_base_url, retry_count = 0)
    response = execute_request(request_opts)
    # begin
    #   response = execute_request(request_opts)
    # rescue SocketError => e
    #   response = handle_restclient_error(e, request_opts, retry_count, api_base_url)
    # rescue NoMethodError => e
    #   # Work around RestClient bug
    #   if e.message =~ /\WRequestFailed\W/
    #     e = APIConnectionError.new('Unexpected HTTP response code')
    #     response = handle_restclient_error(e, request_opts, retry_count, api_base_url)
    #   else
    #     raise
    #   end
    # rescue RestClient::ExceptionWithResponse => e
    #   if e.response
    #     handle_api_error(e.response)
    #   else
    #     response = handle_restclient_error(e, request_opts, retry_count, api_base_url)
    #   end
    # rescue RestClient::Exception, Errno::ECONNREFUSED => e
    #   response = handle_restclient_error(e, request_opts, retry_count, api_base_url)
    # end

    # response
  end
end
