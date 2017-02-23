require 'tamber'
require 'test/unit'
require 'mocha/setup'
require 'stringio'
require 'shoulda'

class Test::Unit::TestCase
  include Mocha

  setup do
    Tamber.project_key = "Mu6DUPXdDYe98cv5JIfX"
    Tamber.engine_key = "SbWYPBNdARfIDa0IIO9L"
  end

  teardown do
    Tamber.project_key = nil
    Tamber.engine_key = nil
  end
end
