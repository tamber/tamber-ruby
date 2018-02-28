module Tamber
  class Event < APIResource

    extend Tamber::APIOperations::Retrieve

    def self.track_url
      url + '/track'
    end

    def self.batch_url
      url + '/batch'
    end

    def self.meta_like_url
      url + '/meta/like'
    end

    def self.meta_unlike_url
      url + '/meta/unlike'
    end

    def self.track(params={})
      response = request(:post, self.track_url, params)
      Util.convert_to_tamber_object(response)
    end

    def self.batch(params={})
      response = request(:post, self.batch_url, params)
      Util.convert_to_tamber_object(response)
    end

    def self.metaLike(params={})
      response = request(:post, self.meta_like_url, params)
      Util.convert_to_tamber_object(response)
    end

    def self.metaUnlike(params={})
      response = request(:post, self.meta_unlike_url, params)
      Util.convert_to_tamber_object(response)
    end

  end
end
