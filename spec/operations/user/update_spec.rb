# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { create(:user) }

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

    it 'returns 200 OK and all users' do
      get users_path, headers: { 'Accept' => 'application/json' }

      expect(response).to have_http_status(:ok)
      expect(parsed_response['users'].size).to eq(3)
    end
  end

  describe '#show' do
    subject(:request) { get user_path(user_id), headers: { 'Accept' => 'application/json' } }

    context 'when user exists' do
      let(:user_id) { user.id }

      it 'returns 200 OK and the user' do
        request
        expect(response).to have_http_status(:ok)
        expect(parsed_response['id']).to eq(user.id)
        expect(parsed_response['email']).to eq(user.email)
      end
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
           params:  { user: params },
           headers: { 'Accept' => 'application/json' }
    end

    context 'with valid params' do
      let(:params) { valid_params }

      it 'creates the user and returns 201 Created' do
        expect { request }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      let(:params) { invalid_params }

      it 'does not create user and returns 422' do
        expect { request }.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#update' do
    subject(:request) do
      patch user_path(user),
            params:  { user: update_params },
            headers: { 'Accept' => 'application/json' }
    end

    context 'with valid params' do
      let(:update_params) { { first_name: 'Updated' } }

      it 'updates the user and returns 200 OK' do
        request
        expect(response).to have_http_status(:ok)
        expect(user.reload.first_name).to eq('Updated')
      end
    end

    context 'with invalid params' do
      let(:update_params) { { email: '' } }

      it 'returns 422 Unprocessable Entity' do
        request
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe '#destroy' do
    subject(:request) do
      delete user_path(user), headers: { 'Accept' => 'application/json' }
    end

    it 'deletes the user and returns 204 No Content' do
      request
      expect(response).to have_http_status(:no_content)
      expect(User).not_to exist(user.id)
    end
  end
end
