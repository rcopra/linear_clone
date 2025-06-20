# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tickets', type: :request do
  let(:user) { create(:user) }
  let(:team) { create(:team) }
  let(:project) { create(:project, team: team) }

  let(:valid_params) do
    {
      title:       'A bug',
      description: 'Fix it',
      status:      'open',
      user_id:     user.id,
      project_id:  project.id
    }
  end

  let(:invalid_params) do
    {
      title:       '',
      description: nil
    }
  end

  describe '#create' do
    subject(:request) { post tickets_path, params: { ticket: params } }

    context 'with valid params' do
      let(:params) { valid_params }
      let(:created_ticket) { Ticket.find(parsed_response['id']) }

      before { request }

      it 'returns 201 created' do
        expect(response).to be_created
        expect(created_ticket).to have_attributes(
          title:       'A bug',
          description: 'Fix it',
          status:      'open'
        )
      end
    end

    context 'with invalid params' do
      let(:params) { invalid_params }

      before { request }

      it 'does not create a ticket and returns 422' do
        expect(response).to be_unprocessable
      end
    end
  end
end
