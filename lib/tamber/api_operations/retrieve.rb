module Tamber
  module APIOperations
    module Retrieve
      def retrieve(params={})
        response = request(:post, url+"/retrieve", params)
        Util.convert_to_tamber_object(response)
      end
    end
  end
end
