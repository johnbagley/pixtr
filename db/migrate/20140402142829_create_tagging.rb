class CreateTagging < ActiveRecord::Migration
  def change
    create_table :taggings do |t|

    t.integer :image_id
    t.integer :tag_id
    
    end
  end
end
