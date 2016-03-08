require 'test_helper'

class Api::V1::LinksControllerTest < ActionController::TestCase
  test "#index returns an array of links" do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test "#index returns correct number of links" do
    get :index, format: :json

    assert_equal Link.count, json_response.count
  end

  test "#index contains ideas that have the correct properties" do
    get :index, format: :json

    json_response.each do |link|
      assert link['title']
      assert link['url']
    end
  end

  test "#create adds a new link to the database" do
    link =  { title: "New Link", url: "http://google.com"  }

    assert_difference 'Link.count', 1 do
      post :create, link: link, format: :json
    end
  end

  test "#create returns a new link with correct properties" do
    link =  { title: "New Link", url: "http://google.com" }

    post :create, link: link, format: :json

    assert link[:title], json_response['title']
    assert link[:url], json_response['url']
  end

  test "#update replaces properties of current idea" do
    skip
    put :update, id: Link.first.id, link: { title: "Updated Link"  }, format: :json

    assert_equal "Updated Link", Link.first.title
  end
end
