class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :title
      t.string :link
      t.string :img
      t.string :via
      t.string :published

      t.timestamps
    end
  end
end
