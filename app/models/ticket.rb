# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :assignee,
             class_name: 'User',
             optional:   true,
             inverse_of: :assigned_tickets
  belongs_to :project

  enum :status, {
    open:        0,
    in_progress: 1,
    closed:      2
  }, validate: true

  validates :status, inclusion: { in: statuses.keys }
  validates :title, :description, presence: true
end
