# Tamber Ruby bindings
# API spec at https://tamber.com/docs/api
require 'cgi'
require 'openssl'
require 'rbconfig'
require 'set'
require 'socket'

require 'rest-client'
require 'json'

require 'tamber/version'

require 'tamber/util'
require 'tamber/tamber_object'
require 'tamber/api_resource'
require 'tamber/event'
require 'tamber/discover'
require 'tamber/user'
require 'tamber/item'
require 'tamber/behavior'
require 'tamber/property'


require 'tamber/tamber_error'


module Tamber

  @api_url = 'https://api.tamber.com/v1'
  @open_timeout = 30
  @read_timeout = 80

  class << self
    attr_accessor :api_key, :api_base, :api_version, :open_timeout, :read_timeout

    # attr_reader :max_network_retry_delay, :initial_network_retry_delay
  end


  def self.api_url(api_base_url=nil, url='')
    (api_base_url || @api_url) + url
  end

  def self.request(method, url, api_key, params={}, headers={}, api_base_url=nil)
    api_base_url = api_base_url || @api_base

    unless api_key ||= @api_key
      raise AuthenticationError.new('No API key provided. ' \
                                    'Set your engine-specific API key using "Tamber.api_key = <ENGINE-API-KEY>". ' \
                                    'You can get your engine\'s api key from the Tamber dashboard. ' \
                                    'See https://dashboard.tamber.com to get your engine\'s key, or ' \
                                    'email support@tamber.com if you have any questions.)')
    end

    if api_key =~ /\s/
      raise AuthenticationError.new('Your API key is invalid, as it contains ' \
                                    'whitespace. (HINT: You can double-check your API key from the ' \
                                    'Tamber dashboard. See https://dashboard.tamber.com to get your engine\'s key, or ' \
                                    'email support@tamber.com if you have any questions.)')
    end

    params = Util.objects_to_ids(params)
    url = api_url(api_base_url,url)

    case method.to_s.downcase.to_sym
    when :get, :head, :delete
      # Make params into GET parameters
      url += "#{URI.parse(url).query ? '&' : '?'}#{Util.encode_parameters(params)}" if params && params.any?
      payload = nil
    else
      if headers[:content_type] && headers[:content_type] == "multipart/form-data"
        payload = params
      else
        payload = Util.encode_parameters(params)
      end
    end

    request_opts = {:headers => request_headers(api_key, method).update(headers),
                    :method => method, :open_timeout => open_timeout,
                    :payload => payload, :url => url, :timeout => read_timeout}

    response = execute_request_with_rescues(request_opts, api_base_url)

    [parse(response)]
  end

  def self.request_headers(api_key, method)
    headers = {
      :user_agent => "Tamber/v1 RubyBindings/#{Tamber::VERSION}",
      :authorization => "Bearer #{api_key}",
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
      :bindings_version => Stripe::VERSION,
      :lang => 'ruby',
      :lang_version => lang_version,
      :platform => RUBY_PLATFORM,
      :engine => defined?(RUBY_ENGINE) ? RUBY_ENGINE : '',
      :publisher => 'tamber',
      :hostname => Socket.gethostname,
    }

  end

  def self.execute_request(opts)
    RestClient::Request.execute(opts)
  end

  def self.parse(response)
    begin
      # Would use :symbolize_names => true, but apparently there is
      # some library out there that makes symbolize_names not work.
      response = JSON.parse(response.body)
    rescue JSON::ParserError
      raise general_api_error(response.code, response.body)
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
