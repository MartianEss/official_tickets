class EventManagers::EventsController < EventManagers::ApplicationController
  def index
    @events = current_event_manager.events.all
  end

  def new
    @event = Event.new
  end

  def show
    @event = current_event_manager.events.find(params[:id])
  end

  def create
    @event = current_event_manager.events.new(event_params)
    if @event.save
      redirect_to event_managers_events_path
    else
      render :new
    end
  end

  def edit
    @event = current_event_manager.events.find(params[:id])
  end

  def update
    @event = current_event_manager.events.find(params[:id])

    if @event.update_attributes(event_params)
      redirect_to event_managers_events_path
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(
      :title,
      :description,
      :location,
      :genre,
      :dress_code,
      :date_from,
      :date_to,
      :time_to,
      :time_from,
      :contact_number,
      :ticket_type,
      :price,
      :tickets_allocated
    )
  end
end
