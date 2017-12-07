class AddUpAndDownVotesToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :upvote, :decimal
    add_column :products, :downvote, :decimal
  end
end
