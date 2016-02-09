module Tamber
  class Discover < APIResource
    extend Tamber::APIOperations::Retrieve

    def recommended_url
      url + '/recommended'
    end

    def similar_url
      url + '/similar'
    end

    def recommended_similar_url
      url + '/recommended_similar'
    end

    def popular_url
      url + '/popular'
    end

    def hot_url
      url + '/hot'
    end

    def recommended(params={})
      response = request(:post, recommended_url, params)
    end

    def similar(params={})
      response = request(:post, similar_url, params)
    end

    def recommended_similar(params={})
      response = request(:post, recommended_similar_url, params)
    end

    def popular(params={})
      response = request(:post, popular_url, params)
    end

    def hot(params={})
      response = request(:post, hot_url, params)
    end

  end
end
