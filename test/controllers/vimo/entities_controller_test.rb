# frozen_string_literal: true

require "test_helper"

module Vimo
  class EntitiesControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @account = Account.create(name: "foo", api_key: "foobar")
    end

    test "index" do
      entity = FactoryBot.create(:entity, owner: @account)
      get entities_path(api_key: "foobar")
      assert_response :success

      assert_equal [entity].to_json, @response.body
    end

    test "show" do
      entity = FactoryBot.create(:entity, owner: @account)
      get entity_path(entity, api_key: @account.api_key)

      assert_response :success
      assert_equal entity.to_json, @response.body
    end

    test "create" do
      post entities_path(api_key: @account.api_key), params: {
        entity: { name: "name_test", system_name: "system_name_test",
                  fields_attributes: [
                    { name: "field1", kind: "string", required: true },
                    { name: "field2", kind: "integer", required: false }
        ] }
      }

      assert_response :success
      entity = Entity.last
      assert_equal entity.to_json, @response.body
      assert_equal 2, entity.fields.count

      field = entity.fields.first
      assert_equal "field1", field.name
      assert_equal "string", field.kind
      assert_equal true, field.required
    end

    test "update" do
      entity = FactoryBot.create(:entity, owner: @account)
      put entity_path(entity, api_key: @account.api_key),
        params: {
          entity: { name: "new_name" }
        }

      assert_response :success
      assert_equal entity.reload.name, "new_name"
    end

    test "destroy" do
      entity = FactoryBot.create(:entity, owner: @account)
      delete entity_path(entity, api_key: @account.api_key)

      assert_response :success
      assert_not Entity.find_by(id: entity.id)
    end
  end
end
