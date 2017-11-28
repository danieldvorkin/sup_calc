class ProductsController < ApplicationController
  before_action :authenticate_user!
  def index
    @data = Product.order('dropweek DESC').all.group_by {|x| x['dropweek']}
    @order_item = current_order.order_items.new
  end
end
