module WelcomeHelper
  
  def self.main_label(data, index, label)
    return "#{data.size - (index + 1)} - Date: #{label.split("/").pop()}"
  end
  
  def self.price_badge(price)
    price.empty? ? "N/A" : price
  end
end
