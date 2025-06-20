# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tickets, inverse_of: :user, dependent: :destroy
  has_many :assigned_tickets,
           foreign_key: :assignee_id,
           class_name:  'Ticket',
           dependent:   :destroy,
           inverse_of:  :assignee

  validates :first_name, :last_name, :email, presence: true

  has_secure_password
end
