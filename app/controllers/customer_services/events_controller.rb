class CustomerServices::EventsController < CustomerServices::ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      CustomerServiceMailer.event_approval(@event).deliver_later

      redirect_to customer_services_event_path(id: @event), notice: 'Event has been approved'
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:approved)
  end
end
