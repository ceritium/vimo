# frozen_string_literal: true

module Extendable
  extend ActiveSupport::Concern

  included do
    has_one :extended, as: :extendable, class_name: "Vimo::Item"

    def self.extendable(options = {})
      @@belongs_to_owner = options[:owner]

      self.class_eval do

        delegate :data, to: :extended

        def vimo_owner
          send(@@belongs_to_owner) if @@belongs_to_owner
        end

        def entities
          if vimo_owner
            vimo_owner.vimo_entities
          else
            Vimo::Entity
          end
        end

        def extended
          super || build_extended(entity: entities.find_or_create_by!(name: "_extend_#{self.class.table_name}"))
        end

        def entity_fields
          @entity_fields ||= extended.entity.fields
        end
      end
    end
  end
end
