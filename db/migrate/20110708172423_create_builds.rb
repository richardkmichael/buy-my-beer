class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.boolean :status
      t.string :name
      t.string :last_commit
      t.integer :last_commiter_id

      t.timestamps
    end
  end
end
