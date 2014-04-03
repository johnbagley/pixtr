class ChangeTexttoNameInTags < ActiveRecord::Migration
  def change
    remove_column :tags, :user_id
    remove_column :tags, :image_id
    rename_column(:tags, :text, :name)
  end
end
