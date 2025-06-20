# frozen_string_literal: true

FactoryBot.define do
  factory :ticket do
    title { 'MyString' }
    description { 'MyText' }
    status { 'MyString' }
    user { nil }
  end
end
