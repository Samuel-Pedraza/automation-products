class CreateModel < ActiveRecord::Migration[5.1]
  def up
  	create_table :models do |t|
  		t.string :name
        t.string :url
        t.integer :price
        t.string :image
        t.string :modelnumber
  	end
  end

  def down
  	drop_table :models
  end
end
