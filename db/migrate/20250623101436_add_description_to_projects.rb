class AddDescriptionToProjects < ActiveRecord::Migration[7.2]
  def change
    add_column :projects, :description, :text
  end
end
