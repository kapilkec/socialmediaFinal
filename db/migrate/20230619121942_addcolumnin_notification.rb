class AddcolumninNotification < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :followed, :boolean
    remove_column :notifications, :read
    add_column :notifications, :hasRead, :boolean, default: false
  end
end
