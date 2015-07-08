class Event < ActiveRecord::Base
  belongs_to :event_manager

  def unapproved?
    !approved
  end
end
