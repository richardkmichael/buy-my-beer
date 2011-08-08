class AddBeersToUser < ActiveRecord::Migration
  def change
    add_column :users, :beers, :integer
  end
end
