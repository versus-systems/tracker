class ChangeTasksTimestampsDefaultToNull < ActiveRecord::Migration
  def change
    change_column_null :tasks, :updated_at, false
    change_column_null :tasks, :created_at, false
  end
end
