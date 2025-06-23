# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :project, only: %i[show update destroy]

  def index
    render json: {
      projects: ProjectBlueprint.render_as_hash(Project.all)
    }
  end

  def show
    render_json_response project, project.present?, status: :ok
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      render json: ProjectBlueprint.render(@project), status: :created
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if project.update(project_params)
      render json: ProjectBlueprint.render(project), status: :ok
    else
      render json: { errors: project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    project.destroy!
    head :no_content
  end

  private

  def project
    @project ||= Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :team_id)
  end
end
