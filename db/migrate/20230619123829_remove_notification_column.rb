class RemoveNotificationColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :notifications, :fromUser
  end
end
