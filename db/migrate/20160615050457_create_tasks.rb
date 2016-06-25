class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :name, null: false
      t.string :description
      t.integer :state, default: 0, null: false
      t.uuid :project_id, index: true, null: false

      t.timestamps null: false
    end
  end
end
