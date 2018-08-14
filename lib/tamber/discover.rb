module Tamber
  class Discover < APIResource
    %w[next recommended weekly daily meta popular hot uac new].each do |method_name|
      define_singleton_method method_name do |params = {}|
        response = request(:get, send("#{method_name}_url"), params)
        Util.convert_to_tamber_object(response)
      end
    end

    %w[next_url new_url recommended_url weekly_url daily_url meta_url
       popular_url hot_url uac_url].each do |method_name|
      define_singleton_method method_name do
        method_name_without_url = method_name.split('_')[0]
        url + "/#{method_name_without_url}"
      end
    end

    class Basic < APIResource
      %w[recommended similar recommendedSimilar].each do |method_name|
        define_singleton_method method_name do |params = {}|
          response = request(:get, send("#{method_name}_url"), params)
          Util.convert_to_tamber_object(response)
        end
      end

      %w[recommended_url similar_url recommendedSimilar_url].each do |method_name|
        define_singleton_method method_name do
          method_name_without_url = method_name.split('_')[0]
          method_name_without_url = Util.underscore(method_name_without_url) if method_name_without_url == 'recommendedSimilar'
          url + "/#{method_name_without_url}"
        end
      end

      def self.recommended_url
        url + '/recommended'
      end

      def self.similar_url
        url + '/similar'
      end

      def self.recommendedSimilar_url
        url + '/recommended_similar'
      end
    end
  end

  # Discover requests return an array of 'discovery' objects
  class Discovery < TamberObject
  end
end
