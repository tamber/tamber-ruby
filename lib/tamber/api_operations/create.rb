module Tamber
  module APIOperations
    module Create
      def create(params={})
        response = request(:post, url, params)
      end
    end
  end
end
