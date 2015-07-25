class EventManagers::TicketsController < EventManagers::ApplicationController
  def used
    @event = Event.find(params[:event_id])
    @tickets_allocation = @event.tickets_allocations.find(params[:tickets_allocation_id])
    @ticket = Ticket.find(params[:ticket_id])
    if @ticket.update_attribute(:used, true)
      redirect_to event_managers_event_tickets_allocations_path(event_id: @event.id)
    else
      redirect_to event_managers_event_tickets_allocation_ticket_path(event_id: @event.id, tickets_allocation_id: @tickets_allocation.id, id: @ticket.id)
    end
  end
end
