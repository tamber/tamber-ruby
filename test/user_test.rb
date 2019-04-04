require File.expand_path('../test_helper', __FILE__)

module Tamber
  class UserTest < Test::Unit::TestCase
    self.test_order = :defined

    usera = 'user_jctzgisbru'
    userb = 'user_lapnesrmr'
    # usera = (0...8).map { (65 + rand(26)).chr }.join
    # userb = (0...8).map { (65 + rand(26)).chr }.join

    should "create and update user" do
      begin
        u = Tamber::User.create(
          :id => usera,
          :events => [
            {
              :item => 'item_u9nlytt3w5',
              :behavior => 'like'
            },
            {
              :item => 'item_i5gq90scc1',
              :behavior => 'like'
            }
          ]
        )
      rescue TamberError => error
        puts error.message
      end
    end

    should "users should be able to be updated" do
      begin
        metadata = {
          'name' => 'Rob Pike',
          'city' => 'Mountain View, CA'
        }
        u = Tamber::User.update(
          :id => usera,
          :metadata => metadata
        )
        puts "retrieved user #{u}"
        assert u.id == usera
      end
    end


    should "retrieve user" do
      begin
        u = Tamber::User.retrieve(
          :id => usera,
          :get_recs => {
            :number => 10
          }
        )
        puts u.inspect
        puts u.metadata
        assert u.id == usera
      end
    end

    # should "search user" do
    #   begin
    #     users = Tamber::User.search(
    #       :filter => {
    #         'city' => 'Mountain View, CA'
    #       }
    #     )
    #     puts users.inspect
    #     # assert users.length >= 1
    #   rescue TamberError => error
    #     puts error.message
    #   end
    # end

    # Breaks production test
    # should "merge user" do
    #   begin
    #     u = Tamber::User.merge(
    #       :from => usera,
    #       :to => userb
    #     )
    #     puts u.inspect
    #     assert u.id == userb
    #   end
    # end

  end
end
