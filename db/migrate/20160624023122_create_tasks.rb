class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.references :project, index: true, foreign_key: true
    end
  end
end
