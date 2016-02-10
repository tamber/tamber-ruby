module Tamber
  class TamberObject

    def initialize(values={})
      values.each do |k,v|
        val = self.class.curvert(v)
        self.instance_variable_set("@#{k}", val)
        self.singleton_class.send(:attr_accessor, k)
      end
    end

    def self.construct_from(values)
      values = Tamber::Util.symbolize_names(values)
      self.new(values)
    end

    def self.curvert(values={})
      case values
      when Hash
        if values.has_key?(:object)
          Tamber::Util.object_classes.fetch(values[:object],TamberObject).new(values)
        else
          values.each do |k,v|
            values[k] = curvert(v)
          end
        end
      when Array
        values.map { |i| curvert(i) }
      else
        values
      end
    end

  end
end
