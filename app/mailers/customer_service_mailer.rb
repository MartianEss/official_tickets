class CustomerServiceMailer < ApplicationMailer
  def event_manager_approval(event_manager)
    @event_manager = event_manager
    mail(to: @event_manager.email, subject: 'Your account has been approved')
  end

  def event_approval(event)
    @event = event
    @event_manager = event.event_manager
    mail(to: @event_manager.email, subject: 'Event approval')
  end
end
