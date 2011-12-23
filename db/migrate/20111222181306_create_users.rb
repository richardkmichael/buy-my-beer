class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string  :email
      t.string  :encrypted_password
      t.string  :salt
      t.integer :beers, :default => 0

      t.timestamps
    end

    add_index :users, :email, :unique => true
  end

  def down
    remove_index :users, :email
    drop_table :users
  end
end
