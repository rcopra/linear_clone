# frozen_string_literal: true

class ProjectBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :description, :created_at, :updated_at

  association :team, blueprint: TeamBlueprint
end
