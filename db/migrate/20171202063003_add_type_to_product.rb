class AddTypeToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :type, :string
  end
end
