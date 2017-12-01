namespace :product_updater do

  desc "TODO"
  task update_products: :environment do
    require 'open-uri'
    puts "Welcome to Product Upodater"

    count = 0
    updated = 0
    doc = Nokogiri::HTML(open("https://www.supremecommunity.com/season/latest/droplists/"))
    all_dates = doc.css('.droplistSelection a').map{|d| d['href'] }.uniq

    all_dates.each_with_index do |date, index|
      puts "Starting #{date}"
      link = "https://www.supremecommunity.com" + date
      page = Nokogiri::HTML(open(link))
      cards = page.css('.card-details')

      skipped = 0
      updated2 = 0
      built = 0

      puts "======================================"
      cards.each_with_index do |card|
        id = card.attr("data-itemid")
        product = Product.find_by_dataId(id)

        if product.nil?
          Product.create!(
            active: true,
            dropweek: date,
            dataId: card.attr('data-itemid'),
            name: card.css('.card__body h5').text,
            title: card.css('.card__body h5').text,
            link: card.css('.card__top img').attr('src'),
            price: card.css('.droplist-price .label-price').text
          )
          built += 1
          count += 1
        else
          product.active = true
          product.dropweek = date
          product.dataId = card.attr('data-itemid')
          product.name = card.css('.card__body h5').text
          product.title = card.css('.card__body h5').text
          product.link = card.css('.card__top img').attr('src')
          product.price = card.css('.droplist-price .label-price').text

          if index < 3
            product.changes.empty? ? next : Thread.new { updated += 1; updated2 += 1}
          end
          product.save!
          next
        end
      end
      puts "Built: #{built} :: Updated: #{updated2} :: Skipped: #{skipped}"
      puts "======================================"
    end

    puts (count + updated) > 0 ? "New Products Added!! Product Updater Complete!!" : "Product Updater Complete!!!"
    (count + updated) > 0 ? UserMailer.products_updated(count, updated).deliver_now : nil
  end
end
