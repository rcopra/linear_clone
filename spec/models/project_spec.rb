# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Project, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:team) }
  end
end
