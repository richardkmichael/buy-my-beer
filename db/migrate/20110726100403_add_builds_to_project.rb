class AddBuildsToProject < ActiveRecord::Migration
  def change
    change_table :builds do |t|
      t.belongs_to :project
    end
  end
end
