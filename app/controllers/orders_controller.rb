class OrdersController < ApplicationController
  before_action :authenticate_ticket_purchaser!

  def index
    @event = Event.where(approved: true).find(params[:event_id])
    @orders = current_ticket_purchaser.orders
  end

  def new
    @event = Event.where(approved: true).find(params[:event_id])
    @tickets_allocation = TicketsAllocation.find(params[:ticket_id])
    @order = Order.new(number_of_tickets: @number_of_tickets)
    @client_token = Braintree::ClientToken.generate
  end

  def create
    @event = Event.where(approved: true).find(params[:event_id])
    @tickets_allocation = TicketsAllocation.find(params[:ticket_id])
    @order = @event.orders.new(order_params)

    if payment_message = @order.process(params[:payment_method_nonce], @tickets_allocation, current_ticket_purchaser)
      redirect_to event_ticket_orders_path(id: @order, event_id: @event.id, ticket_id: @tickets_allocation.id)
    else
      @client_token = Braintree::ClientToken.generate
      flash[:alert] = payment_message.processor_response_text
      @params = params
      render :new
    end
  end

  def show
    @event = Event.where(approved: true).find(params[:event_id])
    @tickets_allocation = TicketsAllocation.find(params[:ticket_id])
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(
      :number_of_tickets
    )
  end
end
