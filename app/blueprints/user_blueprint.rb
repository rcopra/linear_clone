# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id

  view :default do
    fields :first_name, :last_name, :email
  end

  view :admin do
    include_view :default
    field :created_at
  end

  view :session do
    include_view :default
    field :created_at
  end
end
