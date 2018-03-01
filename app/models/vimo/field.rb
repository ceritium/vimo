# frozen_string_literal: true

module Vimo
  class Field < ApplicationRecord
    include SystemName
    belongs_to :entity

    enum kind: [ :string, :integer, :float, :date, :datetime, :boolean ]

    validates :name, presence: true, uniqueness: { scope: :entity_id }

    has_system_name uniqueness_scope: [:entity_id]
  end
end
