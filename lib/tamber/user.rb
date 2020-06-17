module Tamber
  class User < APIResource
    extend Tamber::APIOperations::Create
    extend Tamber::APIOperations::Save
    extend Tamber::APIOperations::Retrieve
    extend Tamber::APIOperations::List

    def self.update(params={})
      warn "[DEPRECATION] `User.update` is deprecated.  Please use `User.save` instead."
      response = request(:post, url + '/update', params)
      Util.convert_to_tamber_object(response)
    end

    def self.search(params={})
      warn "[DEPRECATION] `User.search` is deprecated.  Please use `User.list` instead."
      response = request(:post, url + '/list', params)
      Util.convert_to_tamber_object(response)
    end

    def self.merge(params={})
      response = request(:post, url + '/merge', params)
      Util.convert_to_tamber_object(response)
    end

    # Deprecated in api version 2020-6-11
    def self.update(params={})
      warn "[DEPRECATION] `User.update` is deprecated.  Please use `User.save` instead."
      response = request(:post, url + '/save', params)
      Util.convert_to_tamber_object(response)
    end
    
  end
end
