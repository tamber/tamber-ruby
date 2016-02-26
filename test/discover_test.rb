require File.expand_path('../test_helper', __FILE__)

module Tamber
  class DiscoverTest < Test::Unit::TestCase
    should "return recommendations" do
      begin
        d = Tamber::Discover.recommended(
          :user => '38739',
          :filter => {
            :eq => [
              {"property" => "type"},
              "artwork"
            ]
          }
        )
        d.each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
      rescue TamberError => error
        puts error.message
      end
    end

    # should "return similar" do
    #   begin
    #     d = Tamber::Discover.similar(
    #                                    :item => 'item_i5gq90scc1'
    #     )
    #     puts d
    #   rescue TamberError => error
    #     puts error.message
    #   end
    # end

    # should "return recommendedSimilar" do
    #   begin
    #     d = Tamber::Discover.recommendedSimilar(
    #                                               :user => 'user_jctzgisbru',
    #                                               :item => 'item_i5gq90scc1'
    #     )
    #     puts d
    #   rescue TamberError => error
    #     puts error.message
    #   end
    # end

  end
end
