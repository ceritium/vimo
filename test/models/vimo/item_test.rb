# frozen_string_literal: true

require "test_helper"

module Vimo
  class ItemTest < ActiveSupport::TestCase
    test "validations basics" do
      entity = Entity.create!(name: "name", fields_attributes: [
        { name: "field1", kind: "string", required: true },
      ])

      item = entity.items.build
      item.save

      assert item.errors.messages.present?
      assert_not item.persisted?
      assert_not item.valid?
    end
  end
end
