class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :name
      t.text :description
      t.string :state
      t.uuid :project_id
    end
    add_index :tasks, :project_id
  end
end
