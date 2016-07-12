class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.index :name, unique: true
      t.text :description
      t.integer :state, default: -1
      t.references :project

      t.timestamps null: false
    end
  end
end
