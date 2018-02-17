# frozen_string_literal: true

module Vimo
  class Item < ApplicationRecord
    serialize :data, JSON
    belongs_to :entity
    belongs_to :extendable, polymorphic: true, required: false

    validate :entity_definition

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

    def assign_params(params)
      self.data ||= {}
      self.data = entity.fields.inject(self.data) do |memo, field|

        name = field.name.to_s
        kind = field.kind.to_s

        att = params[name]
        if params.keys.include?(name)
          memo[name] = self.class.parse(att, kind)
        end

        memo
      end
    end

    private

    def entity_definition
      self.data ||= {}
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
