# frozen_string_literal: true

class TicketsController < ApplicationController
  def index
    @pagy, @tickets = pagy(Ticket.all)

    respond_to do |format|
      format.html { @tickets = TicketDecorator.decorate_collection(@tickets) }
      format.json do
        render json: {
          tickets: TicketBlueprint.render_as_hash(@tickets),
          pagy:    pagy_metadata(@pagy)
        }
      end
    end
  end

  def create
    operation = Ticket::Create.new(ticket_create_params.to_h)
    result = operation.call

    if result.success?
      render json: TicketBlueprint.render(result.model), status: :created
    else
      render json: { errors: result.model.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def ticket_create_params
    params.require(:ticket).permit(
      :title,
      :description,
      :status,
      :user_id,
      :project_id
    )
  end
end
