class TicketPurchaserMailer < ApplicationMailer
  def send_tickets(order)
    
    @ticket_purchaser = order.ticket_purchaser
    @event = Event.find(order.event_id)

    mail(to: @ticket_purchaser.email, subject: "#{@event.title} - Official Tickets")
  end
end
