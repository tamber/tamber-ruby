module Tamber
  module APIOperations
    module Remove
      def remove(params={})
        response = request(:get, url+"/remove", params)
        Util.convert_to_tamber_object(response)
      end
    end
  end
end
