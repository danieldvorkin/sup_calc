class ChangeColumnNameTypeToFilter < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :type, :filter
  end
end
