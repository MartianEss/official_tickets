class TicketsController < ApplicationController
  before_action :authenticate_ticket_purchaser!

  def index
    @tickets = Ticket.where(ticket_purchaser: current_ticket_purchaser)
  end
end
