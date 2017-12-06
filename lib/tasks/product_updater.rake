namespace :product_updater do

  desc "TODO"
  task update_products: :environment do
    require 'open-uri'
    puts "Welcome to Product Upodater"
    stat = SystemStat.create!(status: "in_progress", completion_time: nil)
    count = 0
    updated = 0
    times = Benchmark.measure {
      doc = Nokogiri::HTML(open("https://www.supremecommunity.com/season/latest/droplists/"))
      all_dates = doc.css('.droplistSelection a').map{|d| d['href'] }.uniq

      all_dates.each_with_index do |date, index|
        puts "Starting #{date}"
        link = "https://www.supremecommunity.com" + date
        page = Nokogiri::HTML(open(link))
        cards = page.css('.masonry__item')

        skipped = 0
        updated2 = 0
        built = 0

        puts "===================================================="
        puts "\n"
        print "Progress: "
        cards.each do |item|
          card = item.css('.card-details')
          if card.length < 1
            next
          else
            dataId = card[0]["data-itemid"]
            product = Product.find_by_dataId(dataId)
            print "|"

            if product.nil?
              Product.create!(
                active: true,
                dropweek: date,
                filter: item.attr('data-masonry-filter'),
                dataId: dataId,
                name: card.css('.card__body h5').text,
                title: card.css('.card__body h5').text,
                link: card.css('.card__top img').attr('src').value,
                price: card.css('.droplist-price .label-price').text
              )
              built += 1
              count += 1
            else
              # The reason for this, is to use .changes to identify changes
              # update_attr will not return this info which i need to modify the counters.
              product.dropweek = date
              product.filter = item.attr('data-masonry-filter')
              product.dataId = dataId
              product.name = card.css('.card__body h5').text
              product.title = card.css('.card__body h5').text
              product.link = card.css('.card__top img').attr('src').value
              product.price = card.css('.droplist-price .label-price').text

              # Where i use .changes to either go onto next iteration or add to the counters.
              product.changes.empty? ? next : Thread.new { updated += 1; updated2 += 1}
              product.save
              next
            end
          end
        end
        puts "\n"
        puts "Built: #{built} :: Updated: #{updated2} :: Skipped: #{skipped}"
        puts "\n"
        puts "===================================================="
      end
    }
    stat.update_attributes({ 
      status: "complete", 
      products_added: count, 
      products_updated: updated - 160, 
      completion_time: times.real.round(2) 
    })
    
    puts (count + updated) > 0 ? "New Products Added!! Product Updater Complete!!" : "Product Updater Complete!!!"
    (count + updated) > 160 ? UserMailer.products_updated(count, updated).deliver_now : Thread.new { puts 'No Major Updates'; }
  end
end
