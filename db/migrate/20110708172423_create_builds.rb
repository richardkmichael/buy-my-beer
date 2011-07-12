class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.string :name
      t.boolean :status
      t.string :last_commit

      t.timestamps
    end
  end
end
