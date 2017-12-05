class ChangeStatusTypeToString < ActiveRecord::Migration[5.1]
  def self.up
   change_column :system_stats, :status, :string
  end
  def self.down
   change_column :system_stats, :status, :boolean
  end
end
