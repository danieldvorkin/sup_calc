class Order < ApplicationRecord
  belongs_to :order_status
  belongs_to :user
  has_many :order_items, dependent: :destroy
  before_validation :set_order_status, on: :create
  before_save :update_subtotal

  def subtotal
    order_items.map do |item|
      price = Product.find(item.product_id).price.split(" / ").shift(1)[0]
      price.gsub(/[^0-9]/, '').to_i
    end.sum

  end
private
  def set_order_status
    self.order_status_id = 1
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end
end
