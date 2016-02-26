require 'tamber'
require 'test/unit'
require 'mocha/setup'
require 'stringio'
require 'shoulda'

class Test::Unit::TestCase
  include Mocha

  setup do
    Tamber.api_key = "Y2tpJMriyLnNImYKmdPd"
  end

  teardown do
    Tamber.api_key = nil
  end
end
