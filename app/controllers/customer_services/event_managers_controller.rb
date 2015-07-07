class CustomerServices::EventManagersController < CustomerServices::ApplicationController

  def index
    @event_managers = EventManager.all
  end

  def show
    @event_manager = EventManager.find(params[:id])
  end

  def update
    @event_manager = EventManager.find(params[:id])

    if @event_manager.update(event_manager_params)
      CustomerServiceMailer.event_manager_approval(@event_manager).deliver_later

      redirect_to customer_services_event_manager_path(id: @event_manager)
    else
      render :edit
    end
  end

  private

  def event_manager_params
    params.require(:event_manager).permit(:first_name, :last_name, :contact_number, :approved)
  end
end
