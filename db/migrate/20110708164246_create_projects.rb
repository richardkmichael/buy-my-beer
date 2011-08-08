class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :uuid, :limit => 64

      t.timestamps
    end
  end
end
