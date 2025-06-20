class AddAssigneeToTickets < ActiveRecord::Migration[7.2]
  def change
    add_reference :tickets, :assignee, foreign_key: { to_table: :users }, null: true
  end
end
