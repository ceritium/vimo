# frozen_string_literal: true

module Vimo
  module Expandable
    extend ActiveSupport::Concern

    included do
      def self.vimo_expand(options = {})
        @belongs_to_owner = options[:owner]
        data_method = options[:data_method] || "data"

        self.class_eval do
          has_one :expanded, as: :expandable, class_name: "Vimo::Item", autosave: true
          delegate data_method, "#{data_method}=", to: :expanded

          def vimo_owner
            send(@belongs_to_owner) if @belongs_to_owner
          end

          def entities
            if vimo_owner
              vimo_owner.vimo_entities
            else
              Vimo::Entity
            end
          end

          def expanded
            super || build_expanded(entity: entities.find_or_create_by!(name: "_expand_#{self.class.table_name}", expand_model: self.model_name.name))
          end

          def entity_fields
            @entity_fields ||= expanded.entity.fields
          end
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, Vimo::Expandable
