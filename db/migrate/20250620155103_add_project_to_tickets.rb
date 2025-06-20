class AddProjectToTickets < ActiveRecord::Migration[7.2]
  def change
    add_reference :tickets, :project, null: false, foreign_key: true
  end
end
