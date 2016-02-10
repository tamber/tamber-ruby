module Tamber
  module APIOperations
    module Request
      module ClassMethods
        def request(method, url, params={})
          response = Tamber.request(method, url, params)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end

      protected

      def request(method, url, params={})
        self.class.request(method, url, params)
      end
    end
  end
end
