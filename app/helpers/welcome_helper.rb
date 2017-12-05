module WelcomeHelper
  require 'open-uri'
  require 'json'

  def self.main_label(data)
    data[0].split("/").pop()
  end

  def self.price_badge(price)
    price.empty? ? "N/A" : price
  end

  def self.print_price(price)
    "$#{'%.02f' % price}"
  end

  def self.find_conversion
    @conv.nil? ? ApplicationHelper.get_conversion : @conv
  end

  def self.subtotal_price(price)
    if price.nil? || !price.present?
      return "N/A"
    else
      price = price.gsub(/[^0-9a-z ]/i, '').to_i
      final_price = ((price * 0.13) + (price * 1.17) + 20)
      self.print_price(final_price)
    end
  end

  def self.can_price(price)
    if price.nil? || !price.present?
      return "N/A"
    else
      conv = self.find_conversion
      price = price.gsub(/[^0-9a-z ]/i, '').to_i
      final_price = ((price * 0.13) + (price * 1.17) + 20) * conv
      self.print_price(final_price)
    end
  end

  def self.usd_subtotal(prices)
    usd_subtotal = prices.map { |price| price.gsub(/[^0-9a-z ]/i, '').to_i }.sum
    self.print_price(usd_subtotal)
  end

  def self.usd_total(prices)
    usd_subtotal = prices.map { |price| price.gsub(/[^0-9a-z ]/i, '').to_i }.sum
    usd_total = ((usd_subtotal * 0.13) + (usd_subtotal * 1.17) + 20)
    self.print_price(usd_total)
  end

  def self.cad_total(prices)
    conv = self.find_conversion
    usd_subtotal = prices.map { |price| price.gsub(/[^0-9a-z ]/i, '').to_i }.sum
    final_grand_price = (((usd_subtotal * 0.13) + (usd_subtotal * 1.17) + 20) * conv)
    self.print_price(final_grand_price)
  end
end
