module Tamber
  class Behavior < APIResource
    extend Tamber::APIOperations::Create
    extend Tamber::APIOperations::Retrieve
  end
end
