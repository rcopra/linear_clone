class AddTeamToProjects < ActiveRecord::Migration[7.2]
  def change
    add_reference :projects, :team, null: false, foreign_key: true
  end
end
