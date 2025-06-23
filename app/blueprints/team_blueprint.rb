# frozen_string_literal: true

class TeamBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :created_at, :updated_at
end
