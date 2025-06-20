# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ticket, type: :model do
  subject { build(:ticket, user: build(:user)) }

  describe 'validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :description }

    it {
      is_expected.to validate_inclusion_of(:status)
        .in_array(described_class.statuses.keys)
    }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:assignee).class_name('User').optional }
  end
end
