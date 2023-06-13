class RemoveReference < ActiveRecord::Migration[7.0]
  def change
    remove_column :members, :group_id
  end
end
