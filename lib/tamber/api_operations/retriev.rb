module Tamber
  module APIOperations
    module Retrieve
      def retrieve(params={})
        response = request(:post, url, params)
      end
    end
  end
end
