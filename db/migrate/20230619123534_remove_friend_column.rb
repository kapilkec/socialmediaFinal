class RemoveFriendColumn < ActiveRecord::Migration[7.0]
  def change
     add_column :friends, :followed, :boolean, default: true
     remove_column :notifications, :followed, :boolean
  end
end
