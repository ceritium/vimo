class CreateVimoEntities < ActiveRecord::Migration[5.0]
  def change
    create_table :vimo_entities do |t|
      t.string :name
      t.string :system_name
      t.references :owner, polymorphic: true, index: true

      t.timestamps
    end

    add_index :vimo_entities, [:owner_id, :owner_type, :system_name],
      unique: true, name: :entity_unique_system_name
  end
end
