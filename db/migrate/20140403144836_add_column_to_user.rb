class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :upgrade_status, :boolean, default: false
    update "UPDATE users SET upgrade_status = false"
  end
end
