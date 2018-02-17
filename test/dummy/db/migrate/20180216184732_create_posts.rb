# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :account, foreign_key: true

      t.timestamps
    end
  end
end
