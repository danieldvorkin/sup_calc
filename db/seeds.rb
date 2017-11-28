# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

doc = Nokogiri::HTML(open("https://www.supremecommunity.com/season/latest/droplists/"))
all_dates = doc.css('.droplistSelection a').map{|d| d['href'] }.uniq

Product.delete_all

all_dates.each do |date|
  puts "Starting #{date}"
  link = "https://www.supremecommunity.com" + date
  page = Nokogiri::HTML(open(link))
  cards = page.css('.card-details')
  
  cards.each do |card|
    puts "Building product: #{card.css('.card__body h5').text}"
    Product.create!(
      name: card.css('.card__body h5').text,
      title: card.css('.card__body h5').text,
      dropweek: date,
      link: card.css('.card__top img').attr('src'),
      price: card.css('.droplist-price .label-price').text,
      active: true
    )
  end
  puts "======================================"
  puts "======================================"
end

OrderStatus.delete_all
OrderStatus.create! id: 1, name: "In Progress"
OrderStatus.create! id: 2, name: "Placed"
OrderStatus.create! id: 3, name: "Shipped"
OrderStatus.create! id: 4, name: "Cancelled"