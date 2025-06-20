# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :projects, inverse_of: :team, dependent: :destroy

  validates :name, presence: true
end
