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

  describe '#create' do
    subject(:request) { post users_path, params: { user: params } }

    context 'with valid params' do
      let(:params) { valid_params }

      it 'returns 204 Created' do
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
end
