class CreateVimoItems < ActiveRecord::Migration[5.1]
  def change
    create_table :vimo_items do |t|
      t.references :entity, foreign_key: true
      t.references :extendable, polymorphic: true, index: true
      t.text :data

      t.timestamps
    end
  end
end
