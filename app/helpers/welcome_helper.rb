module WelcomeHelper
  
  def self.main_label(data)
    data[0].split("/").pop()
  end
  
  def self.price_badge(price)
    price.empty? ? "N/A" : price
  end
end
