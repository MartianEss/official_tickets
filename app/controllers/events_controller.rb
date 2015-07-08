class EventsController < ApplicationController
  def index
    @events = Event.where(approved: true)
  end

  def show
    begin
      @event = Event.where(approved: true).find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to events_path, notice: 'Event not found'
    end
  end
end
