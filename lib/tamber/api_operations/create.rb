module Tamber
  module APIOperations
    module Create
      def create(params={})
        response = request(:post, url+"/create", params)
        Util.convert_to_tamber_object(response)
      end
    end
  end
end
