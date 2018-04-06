class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    add_breadcrumb "Dropweeks", :products_path

    # All Dropweeks from Products
    @weeks = Product.dropweeks
    @seasons = @weeks.map { |d| ProductsHelper.get_season(d) }.uniq
    # Current Order
    @order_item = current_order.order_items.new
  end

  def specific_week
    add_breadcrumb "< Dropweeks", :products_path

    # Dropweek/Products/Current Order Instance vars
    @dropweek = params[:week]
    @dropweek_param = toggle_slashes(params[:week])
    @products = Product.specific_week(params[:week])
    @order_item = current_order.order_items.new

    # Product filter list
    @filters = Product.filters
    # Set default to 'all'
    @filter = "all"
  end

  def filter_product
    @dropweek = toggle_slashes(params[:week], false)
    @dropweek_param = toggle_slashes(params[:week])
    @filter = params[:filter] || "all"
    @filters = Product.filters
    @order_item = current_order.order_items.new

    @products = if params[:filter] == "all"
      Product.where(dropweek: toggle_slashes(params[:week], false))
    else
      Product.where(dropweek: toggle_slashes(params[:week], false), filter: params[:filter])
    end

    respond_to do |format|
      format.js
    end
  end

  def toggle_slashes(str, toggle = true)
    toggle ? str.gsub("/", " ") : str.gsub(" ", "/")
  end
end
