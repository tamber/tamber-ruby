module Tamber
  class User < APIResource
    extend Tamber::APIOperations::Create
    extend Tamber::APIOperations::Update
    extend Tamber::APIOperations::Retrieve
    extend Tamber::APIOperations::List

    def self.search(params={})
      response = request(:post, url + '/search', params)
      Util.convert_to_tamber_object(response)
    end

    def self.merge(params={})
      response = request(:post, url + '/merge', params)
      Util.convert_to_tamber_object(response)
    end
    
  end
end
