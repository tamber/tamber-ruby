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
        if value.is_a?(Hash) || value.is_a?(Array) || value.is_a?(APIResource)
          result << [calculated_key, value.to_json]
        else
          result << [calculated_key, value]
        end
      end

      result
    end

    def self.object_classes
      @object_classes ||= {
        # Core
        'event' => Event,
        'discovery' => Discovery,

        # Expanded
        'user' => User,
        'item' => Item,
        'behavior' => Behavior,
      }
    end

    def self.convert_full(resp)
      case resp
      when Hash
        object_classes.fetch(resp[:object],TamberObject).construct_from(resp)
      when Array
        resp.map { |i| convert_full(i) }
      else
        resp
      end
    end

    def self.convert_to_tamber_object(resp)
      case resp
      when Hash
        object_classes.fetch(resp[:object],TamberObject).construct_from(resp)
      when Array
        if resp.size == 1
          resp = resp[0]
          self.convert_full(resp)
        else
          resp.map { |i| convert_full(i) }
        end
      else
        resp
      end
    end

    def self.symbolize_names(object)
      case object
      when Hash
        new_hash = {}
        object.each do |key, value|
          key = (key.to_sym rescue key) || key
          new_hash[key] = symbolize_names(value)
        end
        new_hash
      when Array
        object.map { |value| symbolize_names(value) }
      else
        object
      end
    end

    def self.underscore(camel_cased_word)
      camel_cased_word.to_s.gsub(/::/, '/')
                      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
                      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
                      .tr('-', '_')
                      .downcase
    end
  end
end
