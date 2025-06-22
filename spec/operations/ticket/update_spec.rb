# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ticket::Update do
  subject(:operation_result) { described_class.call(ticket, params) }

  let(:team)    { create(:team) }
  let(:project) { create(:project, team: team) }
  let(:user)    { create(:user) }

  let(:ticket) do
    create(:ticket,
           title:       'Old title',
           description: 'Old description',
           status:      'open',
           user:        user,
           project:     project)
  end

  describe '#call' do
    context 'with valid params' do
      let(:params) { { title: 'Updated title', status: 'in_progress' } }

      it { is_expected.to be_success }

      it 'updates the ticket' do
        operation_result
        ticket.reload
        expect(ticket.title).to eq('Updated title')
        expect(ticket.status).to eq('in_progress')
      end
    end

    context 'with invalid params' do
      let(:params) { { title: '' } }

      it { is_expected.not_to be_success }

      it 'does not update the ticket' do
        operation_result
        expect(ticket.reload.title).to eq('Old title')
      end
    end
  end
end
