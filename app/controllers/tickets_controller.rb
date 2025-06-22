# frozen_string_literal: true

class TicketsController < ApplicationController
  before_action :ticket, only: %i[show update]

  def index
    pagy, tickets = pagy(Ticket.all)

    render json: {
      tickets: TicketBlueprint.render_as_hash(tickets),
      pagy:    pagy_metadata(pagy)
    }
  end

  def show
    render_json_response ticket, ticket.present?, status: :ok
  end

  def create
    operation = Ticket::Create.new(
      **ticket_create_params
    )

    result = operation.call

    render_json_response result.model, result.success?, status: :created
  end

  def update
    operation = Ticket::Update.new(ticket, ticket_update_params)
    result = operation.call

    render_json_response(
      result.model, result.success?, blueprint: TicketBlueprint
    )
  end

  private

  def ticket
    @ticket ||= Ticket.find(params[:id])
  end

  def ticket_create_params
    params.require(:ticket).permit(
      :title,
      :description,
      :status,
      :user_id,
      :project_id
    )
  end

  def ticket_update_params
    parameters = %i[title description status user_id project_id]
    params.require(:ticket).permit(*parameters)
  end
end
