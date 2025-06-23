# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  let(:team) { create(:team) }

  describe '#index' do
    subject(:request) { get projects_path }

    let!(:project1) { create(:project, name: 'First Project', team: team) }
    let!(:project2) { create(:project, name: 'Second Project', team: team) }

    before { request }

    it 'returns 200 OK' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns all projects' do
      expect(parsed_response['projects'].count).to eq(2)
      names = parsed_response['projects'].map { |p| p['name'] }
      expect(names).to include('First Project', 'Second Project')
    end
  end

  describe '#show' do
    subject(:request) { get project_path(project_id) }

    let!(:project) { create(:project, name: 'A Project', team: team) }

    context 'when project exists' do
      let(:project_id) { project.id }

      before { request }

      it 'returns 200 OK' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the correct project' do
        expect(parsed_response['id']).to eq(project.id)
        expect(parsed_response['name']).to eq('A Project')
      end
    end

    context 'when project does not exist' do
      let(:project_id) { -1 }

      it 'returns 404 Not Found' do
        request
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#create' do
    it 'creates a project and returns 201' do
      post projects_path,
           params: { project: { name: 'MVP', description: 'A linear clone', team_id: team.id } }

      expect(response).to have_http_status(:created)
      expect(Project.last.name).to eq('MVP')
    end
  end

  describe '#update' do
    subject(:request) { patch project_path(project), params: { project: update_params } }

    let!(:project) { create(:project, name: 'Old Name', description: 'Old desc', team: team) }

    context 'with valid params' do
      let(:update_params) { { name: 'Updated Name', description: 'Updated desc' } }

      it 'updates the project and returns 200 OK' do
        request
        expect(response).to have_http_status(:ok)
        expect(project.reload.name).to eq('Updated Name')
        expect(project.description).to eq('Updated desc')
      end
    end

    context 'with invalid params' do
      let(:update_params) { { name: '' } }

      it 'does not update and returns 422 Unprocessable Entity' do
        request
        expect(response).to have_http_status(:unprocessable_entity)
        expect(project.reload.name).to eq('Old Name')
      end
    end

    context 'when the project does not exist' do
      subject(:request) { patch project_path(-1), params: { project: { name: 'Will Fail' } } }

      it 'returns 404 Not Found' do
        request
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe '#destroy' do
    subject(:request) { delete project_path(project.id) }

    let!(:project) { create(:project, team: team) }

    it 'deletes the project and returns 204 No Content' do
      expect { request }.to change(Project, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    context 'when project does not exist' do
      it 'returns 404 Not Found' do
        delete project_path(-1)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
