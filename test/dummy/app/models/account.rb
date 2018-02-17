# frozen_string_literal: true

class Account < ApplicationRecord
  validates :name, presence: true
  validates :api_key, presence: true

  has_many :vimo_entities, class_name: "Vimo::Entity", as: :owner
  has_many :posts, dependent: :delete_all
end
