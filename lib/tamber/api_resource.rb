module Tamber
  class APIResource < TamberObject
    include Tamber::APIOperations::Request

    def self.class_name
      self.name.split('::')[-1]
    end

    def self.url
      if self == APIResource
        raise TamberError.new('APIResource is an abstract class.  You should perform actions on its subclasses (Event, Discover, etc.)')
      end
      "/#{CGI.escape(class_name.downcase)}"
    end

    def url
      "#{self.class.url}"
    end

  end
end
