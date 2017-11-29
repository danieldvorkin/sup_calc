class Product < ApplicationRecord
  has_many :order_items

  def label
    "(USD): #{self.price.delete(' ').gsub("\n", "").split("/").shift(1)[0]}"
  end
end
