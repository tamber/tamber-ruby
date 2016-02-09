module Tamber
  module APIOperations
    module Remove
      def remove(params={})
        response = request(:delete, url, params)
        # initialize_from(response, opts)
      end
    end
  end
end
