class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    add_breadcrumb "Dropweeks", :products_path
    @weeks = Product.order('dropweek DESC').all.pluck(:dropweek).uniq
    @order_item = current_order.order_items.new
  end

  def specific_week
    add_breadcrumb "< Dropweeks", :products_path
    
    @dropweek = params[:week].gsub("/", " ")
    @data = Product.all.where(dropweek: params[:week])
    @order_item = current_order.order_items.new
    @filters = Product.all.pluck(:filter).uniq.prepend("all").compact
    @filter = "all"
  end
  
  def filter_product
    @dropweek = params[:week]
    @filter = params[:filter] || "all"
    @filters = Product.all.pluck(:filter).uniq.prepend("all").compact
    @order_item = current_order.order_items.new
    
    @data = if params[:filter] == "all"
      Product.where(dropweek: params[:week].gsub(" ", "/"))
    else
      Product.where(dropweek: params[:week].gsub(" ", "/"), filter: params[:filter])
    end

    respond_to do |format|
      format.js
    end
  end

  def get_season(week)
    week.split("/").shift(3).last
  end

  def get_week(week)
    week.split("/").shift(5).last
  end
end
