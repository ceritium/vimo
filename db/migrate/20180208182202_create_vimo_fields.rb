class CreateVimoFields < ActiveRecord::Migration[5.0]
  def change
    create_table :vimo_fields do |t|
      t.string :name
      t.string :system_name
      t.integer :kind
      t.boolean :required
      t.references :entity, foreign_key: true

      t.timestamps
    end

    add_index :vimo_fields, [:entity_id, :system_name],
      unique: true, name: :field_unique_system_name
  end
end
