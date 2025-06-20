# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :email }
  end

  it 'can be created with valid attributes' do
    expect(user).to be_valid
    expect { user.save! }.not_to raise_error
  end

  describe 'associations' do
    it { is_expected.to have_many(:tickets).dependent(:destroy) }
  end
end
