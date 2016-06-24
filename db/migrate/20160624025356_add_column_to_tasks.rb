class AddColumnToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :state, :string, default: 'todo'
  end
end
