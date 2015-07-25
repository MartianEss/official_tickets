class EventManagers::TicketsAllocationsController < EventManagers::ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @tickets_allocations = @event.tickets_allocations
  end

  def show
    @event = Event.find(params[:event_id])
    @tickets_allocation = @event.tickets_allocations.find(params[:id])
    @tickets = Ticket.where(event_id: params[:event_id], tickets_allocation_id: params[:id])
  end

  def new
    @tickets_allocation = TicketsAllocation.new(event_id: params[:event_id])
  end

  def create
    @event = Event.find(params[:event_id])
    @tickets_allocation = @event.tickets_allocations.new(tickets_allocation_params)
    if @tickets_allocation.save
      redirect_to event_managers_event_tickets_allocations_path(event_id: @tickets_allocation.event.id)
    else
      render :new
    end
  end

  def tickets_allocation_params
    params.require(:tickets_allocation).permit(
      :name,
      :price,
      :allocated
    )
  end
end
