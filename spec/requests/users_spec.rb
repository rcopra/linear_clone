# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe '#index' do
    it 'returns 200 ok' do
      get users_url

      expect(response).to have_http_status(:ok)
    end
  end
end
