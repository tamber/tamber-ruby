module Tamber
  module APIOperations
    module Update
      def update(params={})
        response = request(:post, url, params)
      end
    end
  end
end
