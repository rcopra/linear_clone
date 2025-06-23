# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:valid_params) do
    {
      first_name: 'Rick',
      last_name:  'Copra',
      email:      'rick@example.com',
      password:   'secure123'
    }
  end

  let(:invalid_params) do
    {
      first_name: '',
      email:      nil
    }
  end

  describe '#index' do
    before { create_list(:user, 3) }

    it 'returns 200 ok' do
      get users_url

      expect(response).to have_http_status(:ok)
    end
  end

  describe '#show' do
    subject(:request) { get user_path(user_id) }

    let!(:user) { create(:user, first_name: 'Rick') }

    context 'when user exists' do
      let(:user_id) { user.id }

      before { request }

      it 'returns 200 OK' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the correct user' do
        expect(parsed_response['id']).to eq(user.id)
        expect(parsed_response['first_name']).to eq('Rick')
      end

      context 'when user does not exist' do
        let(:user_id) { -1 }

        it 'returns 404 Not Found' do
          request
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    describe '#create' do
      subject(:request) do
        post users_path,
             params: { user: params }
      end

      context 'with valid params' do
        let(:params) { valid_params }

        it 'returns 201 Created' do
          expect { request }.to change(User, :count).by(1)
          expect(response).to have_http_status(:created)
        end
      end

      context 'with invalid params' do
        let(:params) { invalid_params }

        it 'returns 422 Unprocessable Entity' do
          expect { request }.not_to change(User, :count)
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    describe '#update' do
      subject(:request) do
        patch user_path(user),
              params: { user: update_params }
      end

      context 'with valid params' do
        let(:update_params) { { first_name: 'Updated' } }

        it 'updates the user and returns 200 OK' do
          request
          expect(response).to have_http_status(:ok)
          expect(user.reload.first_name).to eq('Updated')
        end
      end
    end
  end
end
