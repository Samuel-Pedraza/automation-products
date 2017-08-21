class AddedWebsite < ActiveRecord::Migration[5.1]
  def change
      add_column :models, :website, :string
  end
end
