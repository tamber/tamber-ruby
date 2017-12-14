require File.expand_path('../test_helper', __FILE__)

module Tamber
  class ItemTest < Test::Unit::TestCase
    should "be creatable" do
      begin
        e = Tamber::Item.create(
          :id => 'item_i5gq90scc1',
          :properties =>  {
            'type'=> 'artwork',
            'artist'=> 'Alexander Calder',
            'img_small'=> 'https://imgs.acalder.png'
          },
          :tags => ['modern', 'acryllic'],
          :created => 1454465400
        )
        puts e
      rescue TamberError => error
        puts error.message
      end
    end

    should "be updatable" do
      begin
        e = Tamber::Item.update(
          :id => 'item_i5gq90scc1',
          :updates => {
            :add => {
              :properties => {
                'available_large' => false,
                'stock' => 89
              }
            },
            :remove => {
              :tags => [
                'casual'
              ]
            }
          }
        )
        puts e
      rescue TamberError => error
        puts error.message
      end
    end

    should "be retrievable" do
      begin
        e = Tamber::Item.retrieve(
          :id => 'item_i5gq90scc1',
        )
        puts e
      rescue TamberError => error
        puts error.message
      end
    end

    should "be hideable" do
      begin
        e = Tamber::Item.hide(
          :id => 'item_i5gq90scc1',
        )
        puts e
      rescue TamberError => error
        puts error.message
      end
    end

    should "be unhideable" do
      begin
        e = Tamber::Item.unhide(
          :id => 'item_i5gq90scc1',
        )
        puts e
      rescue TamberError => error
        puts error.message
      end
    end

  end
end
