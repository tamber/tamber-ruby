module Tamber
  module APIOperations
    module Retrieve
      def retrieve(params={})
        response = request(:get, url+"/retrieve", params)
        Util.convert_to_tamber_object(response)
      end
    end
  end
end
