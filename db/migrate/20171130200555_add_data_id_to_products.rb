class AddDataIdToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :dataId, :string
  end
end
