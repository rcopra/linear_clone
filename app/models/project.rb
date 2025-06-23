# frozen_string_literal: true

class Project < ApplicationRecord
  validates :name, :description, presence: true

  belongs_to :team
end
