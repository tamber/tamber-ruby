module Tamber
  class Event < APIResource
    extend Tamber::APIOperations::Retrieve

    def track_url
      url + '/track'
    end

    def batch_url
      url + '/batch'
    end

    def track(params={})
      response = request(:post, track_url, params)
    end
    def batch(params={})
      response = request(:post, batch_url, params)
    end
  end
end
