class EventManagers::ApplicationController < ApplicationController
  before_action :authenticate_event_manager!

  layout 'event_managers'

  before_action :find_event_manager, if: :current_event_manager

  private

  def find_event_manager
    @event_manager = current_event_manager
  end
end

