class JoiningTables < ActiveRecord::Migration[7.0]
  def change
    create_join_table :members, :groups do |t|
      # additional columns for the join table can be defined here
      t.index [:member_id, :group_id]
      t.index [:member_id, :user_id]
    end
  end
end
