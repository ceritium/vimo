# frozen_string_literal: true

class Account < ApplicationRecord
  validates :name, presence: true
  validates :api_key, presence: true

  vimo_owner
  has_many :posts, dependent: :delete_all
end
