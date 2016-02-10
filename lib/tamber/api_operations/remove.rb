module Tamber
  module APIOperations
    module Remove
      def remove(params={})
        response = request(:delete, url+"/remove", params)
        # initialize_from(response, opts)
      end
    end
  end
end
