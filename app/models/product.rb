class Product < ApplicationRecord
  has_many :order_items

  def label
    "(USD): #{self.price.delete(' ').gsub("\n", "").split("/").shift(1)[0]}"
  end
  
  def self.dropweeks
    self.order('dropweek DESC').all.pluck(:dropweek).uniq
  end
  
  def self.specific_week(dropweek)
    self.all.where(dropweek: dropweek)
  end
  
  def self.filters
    self.all.pluck(:filter).uniq.prepend("all").compact
  end
  
end
