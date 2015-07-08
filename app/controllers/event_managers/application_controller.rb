class EventManagers::ApplicationController < ApplicationController
  before_action :authenticate_event_manager!
end
