class AddProjectForeignKeyToTasksTable < ActiveRecord::Migration
  def change
    add_column :tasks, :project_id, :uuid
  end
end
