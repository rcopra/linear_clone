# frozen_string_literal: true

class Ticket::Update
  include Operation

  def initialize(ticket, update_params)
    @params = if update_params.is_a?(ActionController::Parameters)
                update_params
              else
                update_params.deep_symbolize_keys
              end

    @ticket = ticket
  end

  def call
    if @ticket.update(@params)
      success(@ticket)
    else
      failure(@ticket)
    end
  end
end
