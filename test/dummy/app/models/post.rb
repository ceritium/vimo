# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :account

  vimo_expand owner: :account
end
