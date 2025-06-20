# frozen_string_literal: true

class Ticket::Create
  include Operation

  def initialize(params)
    @params = params
  end

  def call
    ticket = Ticket.new(@params)

    if ticket.save
      success(ticket)
    else
      failure(ticket)
    end
  end
end
