module ApplicationHelper
  def self.get_conversion
    require 'open-uri'
    doc = Nokogiri::HTML(open("http://www.xe.com/currencyconverter/convert/?Amount=1&From=USD&To=CAD"))
    @conv = (doc.css('.uccResultAmount').text).to_f
  end
end
