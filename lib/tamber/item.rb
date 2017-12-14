module Tamber
  class Item < APIResource
    extend Tamber::APIOperations::Create
    extend Tamber::APIOperations::Update
    extend Tamber::APIOperations::Retrieve

    # hide an item from all Discover results
    def self.hide(params={})
      response = request(:post, self.hide_url, params)
      Util.convert_to_tamber_object(response)
    end

    # un-hide an item from all Discover results
    def self.unhide(params={})
      response = request(:post, self.unhide_url, params)
      Util.convert_to_tamber_object(response)
    end

    # permenantly delete an item and all associated events
    def self.delete(params={})
      response = request(:post, self.delete_url, params)
      Util.convert_to_tamber_object(response)
    end

    def self.hide_url
      url + '/hide'
    end

    def self.unhide_url
      url + '/unhide'
    end

    def self.delete_url
      url + '/delete'
    end
  end
end
