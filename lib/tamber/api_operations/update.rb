module Tamber
  module APIOperations
    module Update
      def update(params={})
        response = request(:post, url+"/update", params)
        Util.convert_to_tamber_object(response)
      end
    end
  end
end
