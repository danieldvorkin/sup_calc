class WelcomeController < ApplicationController
  require 'open-uri'
  
  def index
    doc = Nokogiri::HTML(open("https://www.supremecommunity.com/season/latest/droplists/"))
    all_dates = doc.css('.droplistSelection a').map{|d| d['href'] }.uniq
    @data = []
    
    all_dates.each do |date|
      link = "https://www.supremecommunity.com" + date
      page = Nokogiri::HTML(open(link))
      cards = page.css('.card-details')
      product_data = []
      
      cards.each do |card|
        product_data << {
          title: card.css('.card__body h5').text,
          link: card.css('.card__top img').attr('src'),
          price: card.css('.droplist-price .label-price').text
        }
      end
      @data << { date => product_data }
    end
    
    render text: doc
  end
end
