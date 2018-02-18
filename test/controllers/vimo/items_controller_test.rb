# frozen_string_literal: true

require "test_helper"

module Vimo
  class ItemsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Vimo::Engine.routes
      Account.destroy_all
      @account = Account.create(name: "foo", api_key: "foobar")
      @entity = FactoryBot.create(:entity, owner: @account,
        fields_attributes: [
          {
            name: "title",
            kind: "string",
            required: true
          }
      ])
    end

    test "resources routes" do
      assert_recognizes({
        format: :json, controller: "vimo/items",
        action: "index", entity_id: "foo" },
        { path: "/resources/foo", method: :get })

      assert_recognizes({
        format: :json, controller: "vimo/items",
        action: "show", entity_id: "foo", id: "bar" },
        { path: "/resources/foo/bar", method: :get })

      assert_recognizes({
        format: :json, controller: "vimo/items",
        action: "create", entity_id: "foo" },
        { path: "/resources/foo", method: :post })

      assert_recognizes({
        format: :json, controller: "vimo/items",
        action: "update", entity_id: "foo", id: "bar" },
        { path: "/resources/foo/bar", method: :put })

      assert_recognizes({
        format: :json, controller: "vimo/items",
        action: "update", entity_id: "foo", id: "bar" },
        { path: "/resources/foo/bar", method: :patch })

      assert_recognizes({
        format: :json, controller: "vimo/items",
        action: "destroy", entity_id: "foo", id: "bar" },
        { path: "/resources/foo/bar", method: :delete })
    end

    test "index" do
      item = create_item

      get entity_items_path(@entity, api_key: @account.api_key)
      assert_response :success

      assert_equal [item].to_json, @response.body
    end

    test "show" do
      item = create_item

      get entity_item_path(@entity, item, api_key: @account.api_key)
      assert_response :success

      assert_equal item.to_json, @response.body
    end

    test "create" do
      post entity_items_path(@entity, api_key: @account.api_key),
        params: { item: { title: "foo" } }

      assert_response :success
      item = @entity.items.last
      assert_equal item.to_json, @response.body
      assert_equal item.data["title"], "foo"
    end

    test "create error" do
      post entity_items_path(@entity, api_key: @account.api_key),
        params: { item: { title: "" } }

      assert_response 422
      assert_equal ({ errors: { title: ["is required"] } }).to_json, @response.body
    end

    test "update" do
      item = create_item
      put entity_item_path(@entity, item, api_key: @account.api_key),
        params: { item: { title: "new title" } }

      assert_response :success
      item = @entity.items.last
      assert_equal item.data["title"], "new title"
    end

    test "update error" do
      item = create_item
      put entity_item_path(@entity, item, api_key: @account.api_key),
        params: { item: { title: "" } }

      assert_response 422
      assert_equal ({ errors: { title: ["is required"] } }).to_json, @response.body
    end

    test "destroy" do
      item = create_item
      delete entity_item_path(@entity, item, api_key: @account.api_key)

      assert_response :success
      refute Item.find_by(id: item.id)
    end

    private

    def create_item
      item = @entity.items.build
      item.data = { "title" => "foo" }
      item.save!
      item
    end
  end
end
