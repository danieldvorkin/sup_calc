class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = current_user.orders.where(order_status_id: 2).order('updated_at DESC')
  end
  
  def show
    @order = Order.find(params[:id])
  end

  def destroy
    Order.find(params[:id]).destroy
    @order_id = params[:id]
    respond_to do |format|
      format.js
    end
  end
end
