class AddBeersToUser < ActiveRecord::Migration
  def change
    add_column :users, :beers, :integer, :default => 0
  end
end
