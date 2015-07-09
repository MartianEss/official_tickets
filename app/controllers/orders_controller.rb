class OrdersController < ApplicationController
  before_action :authenticate_ticket_purchaser!

  def index
    @event = Event.where(approved: true).find(params[:event_id])
    @orders = current_ticket_purchaser.orders
  end

  def new
    @event = Event.where(approved: true).find(params[:event_id])
    @order = Order.new(number_of_tickets: @number_of_tickets)
  end

  def create
    @event = Event.where(approved: true).find(params[:event_id])
    @order = @event.orders.new(order_params)
    @order.ticket_purchaser = current_ticket_purchaser
    if @order.save!
      redirect_to event_orders_path(@event)
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(
      :number_of_tickets
    )
  end
end
