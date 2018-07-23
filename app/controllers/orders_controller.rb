class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    customer = Customer.find(params[:customer_id])
    @order = customer.orders.find(params[:id])
  end
end