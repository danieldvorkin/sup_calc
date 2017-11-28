class AddDropweekToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :dropweek, :string
  end
end
