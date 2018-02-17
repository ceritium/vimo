# frozen_string_literal: true

module Vimo
  class Entity < ApplicationRecord
    include SystemName

    validates :name, presence: true

    has_system_name uniqueness_scope: [:owner_type, :owner_id]

    has_many :fields
    has_many :items
    belongs_to :owner, polymorphic: true, required: false

    accepts_nested_attributes_for :fields,
      reject_if: :all_blank,
      allow_destroy: true

    def as_json(options = nil)
      super(options.merge(include: :fields))
    end
  end
end
