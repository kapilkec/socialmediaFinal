class CreateCommunities < ActiveRecord::Migration[7.0]
  def change
    create_table :communities do |t|
      t.string :name
      t.string :vision
      t.string :category

      t.timestamps
    end
  end
end
