module Tamber
  module APIOperations
    module List
      def list(params={})
        response = request(:get, url+"/list", params)
        Util.convert_to_tamber_object(response)
      end
    end
  end
end
