require 'tamber'
require 'test/unit'
require 'mocha/setup'
require 'stringio'
require 'shoulda'

class Test::Unit::TestCase
  include Mocha

  setup do
    Tamber.project_key = "Mu6DUPXdDYe98cv5JIfX"
    Tamber.open_timeout = 3
    Tamber.read_timeout = 2
  end

  teardown do
    Tamber.project_key = nil
    Tamber.engine_key = nil
  end
end
