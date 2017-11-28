class OrderItemsController < ApplicationController
  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    @order.save
    session[:order_id] = @order.id

    respond_to do |format|
      format.js
    end
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @order_item.update_attributes(order_item_params)
    @order_items = @order.order_items

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])
    @product_id = @order_item.product.id
    @order_item.destroy
    @order_items = @order.order_items

    respond_to do |format|
      format.js
    end
  end
private
  def order_item_params
    params.require(:order_item).permit(:quantity, :product_id)
  end
end
