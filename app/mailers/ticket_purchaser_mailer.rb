class TicketPurchaserMailer < ApplicationMailer
  def send_tickets(order)
    
    @order = order
    @ticket_purchaser = order.ticket_purchaser
    @tickets_allocation = TicketsAllocation.find(order.tickets_allocation)
    @event = Event.find(order.event_id)

    mail(to: @ticket_purchaser.email, subject: "#{@event.title} - Official Tickets")
  end
end
