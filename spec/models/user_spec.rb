# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is invalid without a first name' do
    user = described_class.new(first_name: nil)
    expect(user).not_to be_valid
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it 'is invalid without a last name' do
    user = described_class.new(last_name: nil)
    expect(user).not_to be_valid
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it 'is invalid without an email' do
    user = described_class.new(email: nil)
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("can't be blank")
  end
end
