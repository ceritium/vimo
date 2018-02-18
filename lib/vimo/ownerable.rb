# frozen_string_literal: true

module Vimo
  module Ownerable
    extend ActiveSupport::Concern

    included do
      def self.vimo_owner(options = {})
        self.class_eval do
          has_many :vimo_entities, class_name: "Vimo::Entity", as: :owner
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, Vimo::Ownerable
