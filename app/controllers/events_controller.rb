class EventsController < ApplicationController
  def index
    @events = Event.approved
  end

  def show
    begin
      @event = Event.approved.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to events_path, notice: 'Event not found'
    end
  end
end
