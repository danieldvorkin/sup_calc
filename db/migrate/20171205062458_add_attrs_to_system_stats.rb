class AddAttrsToSystemStats < ActiveRecord::Migration[5.1]
  def change
    add_column :system_stats, :products_updated, :decimal
    add_column :system_stats, :products_added, :decimal
  end
end
