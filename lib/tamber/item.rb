module Tamber
  class Item < APIResource
    extend Tamber::APIOperations::Create
    extend Tamber::APIOperations::Update
    extend Tamber::APIOperations::Retrieve
    extend Tamber::APIOperations::List

    # hide an item from all Discover results
    # un-hide an item from all Discover results
    # permenantly delete an item and all associated events
    %w[hide unhide delete].each do |method_name|
      define_singleton_method method_name do |params = {}|
        response = request(:post, send("#{method_name}_url"), params)
        Util.convert_to_tamber_object(response)
      end
    end

    %w[hide_url unhide_url delete_url].each do |method_name|
      define_singleton_method method_name do
        method_name_without_url = method_name.split('_')[0]
        url + "/#{method_name_without_url}"
      end
    end
  end
end
