class AddExpirationTimeToStorys < ActiveRecord::Migration[7.0]
  def change
    add_column :stories, :expiration_time, :datetime
  end
end
