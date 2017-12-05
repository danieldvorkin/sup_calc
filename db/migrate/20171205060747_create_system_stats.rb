class CreateSystemStats < ActiveRecord::Migration[5.1]
  def change
    create_table :system_stats do |t|
      t.float :completion_time
      t.boolean :status
      t.timestamps
    end
  end
end
