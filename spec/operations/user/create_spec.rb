# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User::Create do
  describe '#call' do
    subject(:result) { described_class.call(params) }

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

    context 'with valid params' do
      let(:params) { valid_params }

      it { is_expected.to be_success }
    end

    context 'with invalid params' do
      let(:params) { invalid_params }

      it 'returns a failure result with errors' do
        expect(result).not_to be_success
        expect(result.model.errors).not_to be_empty
      end
    end
  end
end
