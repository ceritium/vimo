# frozen_string_literal: true

require "test_helper"

module Vimo
  class EntityTest < ActiveSupport::TestCase
    test "create a entity" do
      entity = Entity.create(name: "name")
      assert entity.persisted?
    end

    test "create a entity with fields" do
      entity = Entity.create!(name: "name", fields_attributes: [
        { name: "field1", kind: "string", required: false },
        { name: "field2", kind: "integer", required: true }
      ])

      fields = entity.fields
      assert_equal fields[0].name, "field1"
      assert_equal fields[0].kind, "string"
      assert_equal fields[0].required, false

      assert_equal fields[1].name, "field2"
      assert_equal fields[1].kind, "integer"
      assert_equal fields[1].required, true
    end
  end
end
