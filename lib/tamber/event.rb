module Tamber
  class Event < APIResource

    extend Tamber::APIOperations::Retrieve

    %w[track_url batch_url].each do |method_name|
      define_singleton_method method_name do
        method_name_without_url = method_name.split('_')[0]
        url + "/#{method_name_without_url}"
      end
    end

    %w[meta_like_url meta_unlike_url].each do |method_name|
      define_singleton_method method_name do
        method_name_without_url = method_name.split('_')[1]
        url + "/meta/#{method_name_without_url}"
      end
    end

    %w[track batch metaLike metaUnlike].each do |method_name|
      define_singleton_method method_name do |params = {}|
        method_name = Util.underscore(method_name) if %w[metaLike metaUnlike].include?(method_name)
        response = request(:post, send("#{method_name}_url"), params)
        Util.convert_to_tamber_object(response)
      end
    end
  end
end
