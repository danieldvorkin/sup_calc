class OrdersController < ApplicationController
  def index
    @orders = current_user.orders.where(order_status_id: 2)
  end

  def destroy
    Order.find(params[:id]).destroy
    @order_id = params[:id]
    respond_to do |format|
      format.js
    end
  end
end