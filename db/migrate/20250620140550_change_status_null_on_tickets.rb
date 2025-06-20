class ChangeStatusNullOnTickets < ActiveRecord::Migration[7.2]
  def change
    change_column_null :tickets, :status, false
  end
end
