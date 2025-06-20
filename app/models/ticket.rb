# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :assignee,
             class_name: 'User',
             optional:   true,
             inverse_of: :assigned_tickets
  belongs_to :project

  enum :status, {
    open:        'open',
    in_progress: 'in_progress',
    closed:      'closed'
  }, prefix: :status

  validates :title, :description, presence: true
end
