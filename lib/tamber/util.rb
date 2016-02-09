require "cgi"
require "json"

module Tamber
  module Util

    def self.encode_parameters(params)
      Util.flatten_params(params).
        map { |k,v| "#{url_encode(k)}=#{url_encode(v)}" }.join('&')
    end

    def self.url_encode(key)
      CGI.escape(key.to_s).
        gsub('%5B', '[').gsub('%5D', ']')
    end

    def self.flatten_params(params, parent_key=nil)
      result = []

      params.sort_by { |(k, v)| k.to_s }.each do |key, value|
        calculated_key = parent_key ? "#{parent_key}[#{key}]" : "#{key}"
        if value.is_a?(Hash) || value.is_a?(Array)
          result << [calculated_key, value.to_json]
        else
          result << [calculated_key, value]
        end
      end

      result
    end

  end
end
