# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'Rick' }
    last_name { 'Copra' }
    email { 'rick@example.com' }
    password_digest { 'secure123' }
  end
end
