module Tamber
  class Item < APIResource
    extend Tamber::APIOperations::Create
    extend Tamber::APIOperations::Update
    extend Tamber::APIOperations::Retrieve
    extend Tamber::APIOperations::Remove
  end
end
