class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.integer :state, default: 0
      t.uuid :project_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
