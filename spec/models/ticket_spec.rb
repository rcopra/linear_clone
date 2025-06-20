# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ticket, type: :model do
  subject { build(:ticket, user: build(:user)) }

  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :description }

    it 'has expected enum keys' do
      expect(described_class.statuses.keys).to match_array(%w[open in_progress closed])
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:assignee).class_name('User').optional }
  end
end
