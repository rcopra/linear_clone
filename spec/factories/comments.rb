# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body { 'A comment' }
    user
    ticket
  end
end
