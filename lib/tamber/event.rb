module Tamber
  class Event < APIResource

    extend Tamber::APIOperations::Retrieve

    def self.track_url
      url + '/track'
    end

    def self.batch_url
      url + '/batch'
    end

    def self.track(params={})
      response = request(:post, self.track_url, params)
      Util.convert_to_tamber_object(response)
    end

    def self.batch(params={})
      response = request(:post, self.batch_url, params)
      Util.convert_to_tamber_object(response)
    end
  end
end
