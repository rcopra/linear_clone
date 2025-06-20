# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    title { 'Fix App' }
    description { 'Ticket outlining steps to fix the app' }
    status { 'in_progress' }
    user
  end
end
