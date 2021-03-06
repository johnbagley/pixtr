class AddColumnsToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :actor_id, :integer
    add_column :activities, :target_id, :integer
    add_column :activities, :target_type, :string

    add_index :activities, [:target_id, :target_type]
  end
end
