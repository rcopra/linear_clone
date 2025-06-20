# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ticket::Create do
  describe '#call' do
    subject(:result) { described_class.call(params) }

    let(:valid_user) { create(:user) }

    context 'with valid params' do
      let(:team) { create(:team) }
      let(:project) { create(:project, team: team) }

      let(:params) do
        {
          title:       'Sample Ticket',
          description: 'Some issue',
          status:      'open',
          user_id:     valid_user.id,
          project_id:  project.id
        }
      end

      it { is_expected.to be_success }
    end

    context 'with invalid params' do
      let(:params) { { title: '', user_id: nil } }

      it 'fails and returns errors' do
        expect(result).not_to be_success
        expect(result.model.errors).not_to be_empty
      end
    end
  end
end
