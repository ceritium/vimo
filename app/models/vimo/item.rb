# frozen_string_literal: true

module Vimo
  class Item < ApplicationRecord
    serialize :data, JSON
    belongs_to :entity
    belongs_to :expandable, polymorphic: true, required: false

    validate :entity_definition
    validate :expanded
    validates :expandable_id, uniqueness: { scope: :expandable_type },
      allow_nil: true

    class << self
      def parse(value_o, kind)
        value = value_o.to_s
        begin
          case kind
          when :string
            value.to_s
          when :integer
            value.to_i
          when :float
            value.to_f
          when :boolean
            value.to_bool unless value_o.nil?
          when :date
            Date.parse(value).to_date.to_s(:db)
          when :datetime
            DateTime.constantize.parse(value).to_datetime.to_s(:db)
          else
            value
          end
        rescue => e
          puts e
          nil
        end
      end
    end

    def data
      read_attribute(:data) || {}
    end

    def as_json(options = nil)
      ({ id: id }).merge(data)
    end

    private

    def expanded
      if entity.expand_model.present?
        if expandable.present?
          unless expandable.model_name.name == entity.expand_model
            errors.add(:expandable, "is invalid")
          end
        else
          errors.add(:expandable, "is required")
        end
      end
    end

    def entity_definition
      entity.fields.each do |field|
        name = field.name.to_s
        if field.required
          if self.data[name].to_s.blank?
            errors.add(name, "is required")
          end
        end
      end
    end
  end
end
