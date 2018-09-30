# frozen_string_literal: true

require "test_helper"

class PostTest < ActiveSupport::TestCase
  setup do
    @account = FactoryBot.create(:account)
    @entity = @account.posts.build.expanded.entity
    @entity.fields.create(name: "summary", required: true, kind: "string")
  end

  test "extended" do
    post = @account.posts.build
    vimo = post.expanded
    assert_kind_of Vimo::Item, vimo
    assert_equal @entity, vimo.entity

    assert_equal Hash.new, post.data

    post.data["summary"] = "foo"
    assert({ "summary" => "foo" }, post.data)

    item = @entity.items.create(data: { summary: "foo" })
    assert item.errors[:expandable]

    item = @entity.items.create(data: { summary: "foo" }, expandable: @account)
    assert item.errors[:expandable]

    post = @account.posts.create
    item = @entity.items.create(data: { summary: "foo" }, expandable: post)
    assert item.persisted?

    item = @entity.items.create(data: { summary: "foo" }, expandable: post)
    assert_not item.persisted?

    item = @entity.items.build(data: { summary: "foo" }, expandable: post)

    assert_raises ActiveRecord::RecordNotUnique do
      item.save(validate: false)
    end

    assert_equal post.data, "summary" => "foo"
    post.data = { "summary" => "bar" }
    post.save
    post.reload
    assert_equal post.data, "summary" => "bar"
    post.data["summary"] = "foobar"
    post.save
    post.reload
    assert_equal post.data, "summary" => "foobar"
  end
end
