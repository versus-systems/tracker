class AddPhoneToProject < ActiveRecord::Migration
  def change
    add_column :projects, :phone, :string
  end
end
