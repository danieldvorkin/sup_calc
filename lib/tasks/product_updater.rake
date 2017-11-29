namespace :product_updater do
  desc "TODO"
  task update_products: :environment do
    require 'open-uri'
    puts "Welcome to Product Upodater"

    count = 0
    doc = Nokogiri::HTML(open("https://www.supremecommunity.com/season/latest/droplists/"))
    all_dates = doc.css('.droplistSelection a').map{|d| d['href'] }.uniq

    all_dates.each do |date|
      puts "Starting #{date}"
      link = "https://www.supremecommunity.com" + date
      page = Nokogiri::HTML(open(link))
      cards = page.css('.card-details')


      cards.each do |card|
        puts "Search for product: #{card.css('.card__body h5').text}"
        next if Product.find_by_name(card.css('.card__body h5').text).present?

        count += 1
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

    puts count > 0 ? "#{count} #{"product".pluralize(count)} Added!! Product Updater Complete!!" : "Product Updater Complete!!!"
    UserMailer.products_updated(count).deliver_now
  end
end
