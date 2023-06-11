class CreateFriends < ActiveRecord::Migration[7.0]
  def change
    create_table :friends do |t|
      t.string :fromUser
      t.string :toUser

      t.timestamps
    end
  end
end
