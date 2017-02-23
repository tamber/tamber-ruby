module Tamber
  class Discover < APIResource

    def self.recommended(params={})
      response = request(:get, self.recommended_url, params)
      Util.convert_to_tamber_object(response)
    end

    def self.similar(params={})
      response = request(:get, self.similar_url, params)
      Util.convert_to_tamber_object(response)
    end

    def self.recommendedSimilar(params={})
      response = request(:get, self.recommendedSimilar_url, params)
      Util.convert_to_tamber_object(response)
    end

    def self.popular(params={})
      response = request(:get, self.popular_url, params)
      Util.convert_to_tamber_object(response)
    end

    def self.hot(params={})
      response = request(:get, self.hot_url, params)
      Util.convert_to_tamber_object(response)
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

    def self.popular_url
      url + '/popular'
    end

    def self.hot_url
      url + '/hot'
    end

  end

  # Discover requests return an array of 'discovery' objects
  class Discovery < TamberObject
  end
end
