require 'tamber'
require 'test/unit'
require 'mocha/setup'
require 'stringio'
require 'shoulda'

class Test::Unit::TestCase
  include Mocha

  setup do
    Tamber.api_key = "IVRiX25dr5rsJ0TDdVOD"
  end

  teardown do
    Tamber.api_key = nil
  end
end
