class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :state, default: 0
      t.belongs_to :project, index: true, type: :uuid
      t.timestamps null: false
    end
  end
end
