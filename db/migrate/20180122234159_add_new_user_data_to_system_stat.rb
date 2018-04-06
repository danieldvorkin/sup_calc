class AddNewUserDataToSystemStat < ActiveRecord::Migration[5.1]
  def change
    add_column :system_stats, :users_added, :integer
  end
end
