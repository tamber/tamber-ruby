module Tamber
  module APIOperations
    module Save
      def save(params={})
        response = request(:post, url+"/save", params)
        Util.convert_to_tamber_object(response)
      end
    end
  end
end
