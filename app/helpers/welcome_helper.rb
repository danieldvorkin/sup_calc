module WelcomeHelper
  
  def self.main_label(data, index)
    data.size - (index + 1)
  end
  
  def self.price_badge(price)
    price.empty? ? "N/A" : price
  end
end
