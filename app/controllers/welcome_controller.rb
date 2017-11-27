class WelcomeController < ApplicationController
  require 'open-uri'
  
  class Entry
    def initialize(title, link)
      @title = title
      @link = link
    end
    attr_reader :title
    attr_reader :link
  end
  
  def index
    
    doc = Nokogiri::HTML(open("https://www.supremecommunity.com/season/latest/droplists/"))
    latestDropLink = "https://www.supremecommunity.com/" + doc.css('.droplistSelection .col-sm-4>a')[0]['href']
    latestDropPage = Nokogiri::HTML(open(latestDropLink))
    cards = latestDropPage.css('.card-details')
    
    @data = []
    cards.each do |card|
      title = card.css('.card__body h5').text
      link = card.css('.card__top img').attr('src')
      @data << Entry.new(title, link)
    end
    
    render text: doc
  end
end
