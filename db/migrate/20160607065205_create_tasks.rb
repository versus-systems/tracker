class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks, id: :uuid  do |t|
      t.string :name
      t.text :description
      t.integer :state, default: 10
      t.uuid :project_id

      t.timestamps null: false
    end

    add_foreign_key :tasks, :projects
  end
end
