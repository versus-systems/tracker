class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string  :project_id
      t.string  :name
      t.text    :description
      t.integer :state, default: 10 # active

      t.timestamps null: false
    end
  end
end
