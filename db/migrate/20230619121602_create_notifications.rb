class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :friend, null: false, foreign_key: true
      t.string :fromUser
      t.boolean :read

      t.timestamps
    end
  end
end
