class ProductsController < ApplicationController
  before_action :authenticate_user!
  def index
    @weeks = Product.order('dropweek DESC').all.pluck(:dropweek).uniq
    @order_item = current_order.order_items.new
  end

  def specific_week
    @data = Product.all.where(dropweek: "/season/fall-winter2017/droplist/2017-11-30")
    @order_item = current_order.order_items.new
  end
end
