class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.belongs_to :project, type: :uuid
      t.references :project, type: :uuid
    end
  end
end
