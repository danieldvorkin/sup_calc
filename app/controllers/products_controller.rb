class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    add_breadcrumb "Dropweeks", :products_path
    @weeks = Product.order('dropweek DESC').all.pluck(:dropweek).uniq
    @order_item = current_order.order_items.new
  end

  def specific_week
    add_breadcrumb "< Dropweeks", :products_path
    add_breadcrumb "Release: #{params[:week]}", specific_week_path(params[:week])
    @dropweek = params[:week]
    @data = Product.all.where(dropweek: params[:week])
    @order_item = current_order.order_items.new
    @filters = Product.all.pluck(:filter).uniq.prepend("all")
    @filter = ''
  end
  
  def filter_product
    @dropweek = params[:week].gsub(" ", "/")
    @filter = params[:filter]
    @data = if params[:filter] == "all"
      Product.where(dropweek: @dropweek)
    else
      Product.where(dropweek: @dropweek, filter: params[:filter])
    end
    @filters = Product.all.pluck(:filter).uniq.prepend("all")
    @order_item = current_order.order_items.new

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
