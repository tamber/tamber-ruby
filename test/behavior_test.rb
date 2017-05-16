require File.expand_path('../test_helper', __FILE__)

module Tamber
  class BehaviorTest < Test::Unit::TestCase
    should "be creatable" do
      begin
        e = Tamber::Behavior.create(
          :name => 'mention',
          :desirability => 0.2
        )
        puts e
      end
    end

    should "be retrievable" do
      begin
        e = Tamber::Behavior.retrieve(
          :name => 'mention',
        )
        puts e
      end
    end
  end
end
