class AddLikableToLikes < ActiveRecord::Migration
  def change
    rename_column :likes, :image_id, :likable_id
    add_column :likes, :likable_type, :string
    add_index :likes, [:likable_id, :likable_type]

    update "UPDATE likes SET likable_type = 'Image'"
  end
end
