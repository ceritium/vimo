# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :account

  extendable owner: :account
end
