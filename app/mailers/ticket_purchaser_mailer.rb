class TicketPurchaserMailer < ApplicationMailer
  def send_tickets(order)
    
    @order = order
    @ticket_purchaser = order.ticket_purchaser
    @tickets_allocation = TicketsAllocation.find(order.tickets_allocation)
    @event = Event.find(order.event_id)

    pdf_job = GeneratePdf.new(order.id)
    pdf_job.perform

    pdf_path = Rails.root.join('tmp', "#{order.id}.pdf")
    attachments['tickets.pdf'] = File.read(pdf_path)

    mail(to: @ticket_purchaser.email, subject: "#{@event.title} - Official Tickets")
  end
end
