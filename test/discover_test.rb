require File.expand_path('../test_helper', __FILE__)

module Tamber
  class DiscoverTest < Test::Unit::TestCase
    # should "return next for the user" do
    #   begin
    #     d = Tamber::Discover.next(
    #       :user => 'user_jctzgisbru'
    #     )
    #     d.each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
    #   end
    # end

    # should "return next for the user given the current item" do
    #   begin
    #     d = Tamber::Discover.next(
    #       :user => 'user_jctzgisbru',
    #       :item => 'item_i5gq90scc1'
    #     )
    #     d.each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
    #   end
    # end

    # should "return next for any user (e.g. a visitor without an id) given the current item" do
    #   begin
    #     d = Tamber::Discover.next(
    #       :item => 'item_i5gq90scc1'
    #     )
    #     d.each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
    #   end
    # end
     
    # should "return new" do
    #   begin
    #     d = Tamber::Discover.new()
    #     d.each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
    #   end
    # end

    should "return hot" do
      begin
        d = Tamber::Discover.hot()
        d.each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
      end
    end

    should "return popular" do
      begin
        d = Tamber::Discover.popular()
        d.each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
      end
    end

    should "return up-and-coming" do
      begin
        d = Tamber::Discover.uac()
        d.each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
      end
    end

    should "return recommendations" do
      begin
        d = Tamber::Discover.recommended(
          :user => 'user_jctzgisbru',
          :get_properties => true,
          :filter => {
            :eq => [
              {"property" => "clothing_type"},
              "pants"
            ]
          }
        )
        d.each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
      end
    end

    should "return similar" do
      begin
        d = Tamber::Discover::Basic.similar(
          :item => 'item_i5gq90scc1'
        )
        d.each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
      end
    end

    should "return recommendedSimilar" do
      begin
        d = Tamber::Discover::Basic.recommendedSimilar(
          :user => 'user_jctzgisbru',
          :item => 'item_i5gq90scc1'
        )
        d.each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
      end
    end

    should "return user hot" do
      begin
        d = Tamber::Discover::UserTrend.hot(
          :user => 'user_jctzgisbru'
        )
        d.each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
      end
    end

  end
end
