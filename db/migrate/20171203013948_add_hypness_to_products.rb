class AddHypnessToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :hype, :string
    add_column :products, :hype_price, :string
  end
end
