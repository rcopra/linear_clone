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

  describe '#index' do
    subject(:request) { get tickets_path }

    let!(:ticket1) { create(:ticket, title: 'First Ticket', project: project, user: user) }
    let!(:ticket2) { create(:ticket, title: 'Second Ticket', project: project, user: user) }

    before { request }

    it 'returns 200 OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all tickets and pagination metadata' do
      expect(parsed_response['tickets'].count).to eq(2)
      titles = parsed_response['tickets'].map { |t| t['title'] }
      expect(titles).to include('First Ticket', 'Second Ticket')

      expect(parsed_response['pagy']).to include('page', 'limit', 'count', 'pages')
    end
  end

  describe '#show' do
    subject(:request) { get ticket_path(ticket_id) }

    let!(:ticket) { create(:ticket, title: 'Detailed Ticket', project: project, user: user) }

    context 'when ticket exists' do
      let(:ticket_id) { ticket.id }

      before { request }

      it 'returns 200 OK' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the correct ticket' do
        expect(parsed_response['id']).to eq(ticket.id)
        expect(parsed_response['title']).to eq('Detailed Ticket')
      end
    end

    context 'when ticket does not exist' do
      let(:ticket_id) { -1 }

      it 'returns 404 Not Found' do
        request
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    subject(:request) { post tickets_path, params: { ticket: params } }

    let(:params) { valid_params }

    context 'with valid params' do
      let(:params) { valid_params }

      it 'returns 201 created' do
        request
        expect(response).to be_created
      end

      it 'creates a ticket' do
        request
        expect(Ticket.last).to have_attributes(
          title:       'A bug',
          description: 'Fix it',
          status:      'open'
        )
      end
    end

    context 'with invalid params' do
      let(:params) { invalid_params }

      it 'returns 422' do
        request
        expect(response).to be_unprocessable
      end
    end
  end

  describe '#update' do
    subject(:request) { patch ticket_path(ticket), params: { ticket: update_params } }

    let!(:ticket) { create(:ticket, title: 'Original Title', project:, user:) }

    context 'with valid params' do
      let(:update_params) { { title: 'Updated Title' } }

      it 'returns 200 OK' do
        request
        expect(response).to have_http_status(:ok)
      end

      it 'updates the ticket' do
        expect { request }.to change { ticket.reload.title }.to('Updated Title')
      end
    end

    context 'with invalid params' do
      let(:update_params) { { title: '' } }

      it 'returns 422' do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the ticket does not exist' do
      subject(:request) do
        patch ticket_path(-1), params: { ticket: { title: 'Should Fail' } }
      end

      it 'returns 404' do
        request
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#destroy' do
    subject(:request) { delete ticket_path(ticket.id) }

    let!(:ticket) { create(:ticket, project:, user:) }

    it 'deletes the ticket and returns 204 No Content' do
      expect { request }.to change(Ticket, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    context 'when ticket does not exist' do
      it 'returns 404 Not Found' do
        delete ticket_path(-1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
