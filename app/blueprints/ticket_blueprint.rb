# frozen_string_literal: true

class TicketBlueprint < Blueprinter::Base
  identifier :id

  view :default do
    fields :title, :description, :status, :created_at, :updated_at
    field :user_id
    field :assignee_id
    field :project_id
  end

  view :detailed do
    include_view :default
    association :user, blueprint: UserBlueprint, view: :default
    association :assignee, blueprint: UserBlueprint, view: :default
  end
end
