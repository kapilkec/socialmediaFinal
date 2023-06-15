class AddNameTodeviseuser < ActiveRecord::Migration[7.0]
  def change
    add_column :deviseusers, :name, :string
  end
end
