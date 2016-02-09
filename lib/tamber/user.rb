module Tamber
  class User < APIResource
    extend Tamber::APIOperations::Create
    extend Tamber::APIOperations::Update
    extend Tamber::APIOperations::Retrieve
  end
end
