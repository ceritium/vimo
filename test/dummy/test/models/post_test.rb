# frozen_string_literal: true

require "test_helper"

class PostTest < ActiveSupport::TestCase
  setup do
    @account = FactoryBot.create(:account)
    @entity = @account.vimo_entities.create(name: "_extend_posts")
    @entity.fields.create(name: "summary", required: true, kind: "string")
  end

  test "extended" do
    post = @account.posts.build
    vimo = post.extended
    assert_kind_of Vimo::Item, vimo
    assert_equal @entity, vimo.entity

    assert_equal Hash.new, post.data

    post.data["summary"] = "foo"
    assert({ "summary" => "foo" }, post.data)
  end
end
