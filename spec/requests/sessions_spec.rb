# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe '#create' do
    subject(:request) { post session_path, params: { session: credentials } }

    let!(:user) { create(:user, password: 'secure123') }

    context 'with valid credentials' do
      let(:credentials) { { email: user.email, password: 'secure123' } }

      it 'returns 200 OK and logs the user in' do
        request

        expect(response).to have_http_status(:ok)
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context 'with invalid credentials' do
      let(:credentials) { { email: user.email, password: 'wrong' } }

      it 'returns 401 Unauthorized' do
        request

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#destroy' do
    let(:user) { create(:user) }

    before do
      post session_path, params: { session: { email: user.email, password: 'secure123' } }
    end

    it 'logs out the user and clears the session' do
      delete session_path

      expect(response).to have_http_status(:no_content)
      expect(session[:user_id]).to be_nil
    end
  end
end
