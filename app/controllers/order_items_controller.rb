class OrderItemsController < ApplicationController
  def create
    @order = current_order
    @order_item = @order.order_items.new(order_item_params)
    @order.user = current_user
    @order.save
    session[:order_id] = @order.id

    respond_to do |format|
      format.js
    end
  end

  def save_order
    @order = current_order
    @order.update_attributes(order_status_id: 2)
    @order.save
    session[:order_id] = nil

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
    @product_id = @order_item.product.dataId
    @order_item.destroy
    @order_items = @order.order_items

    respond_to do |format|
      format.js
    end
  end

  def reset_order
    @order = current_order
    @order.order_items.destroy_all
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
