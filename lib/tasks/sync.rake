namespace :sync do
  desc "TODO"
  task newsfeed: :environment do
    require 'open-uri'
    puts "Welcome to NewsFeed Updater"
    (1..10).each do |page|
      puts "Page #{page}: Starting Scrape"
      doc = Nokogiri::HTML(open("https://www.supremecommunity.com/news/#{page}"))
      cards = doc.css('.masonry__item')
      
      if cards.length > 0      
        cards.each do |card|
          link = card.css('a.block').attr("href").value
          entry = Entry.find_by_link(link)
          
          if entry.nil?
            puts "New Entry: Creating"
            Entry.create!(
              link: link,
              img: card.css('.background-image-holder img').attr('src').value,
              published: card.css('.news-date').text(),
              via: card.css('.news-via-2').text(),
              title: card.css('h4').text()
            )
            puts "New Entry: Complete"
          else 
            puts "Skipping"
          end
        end
        puts "Page #{page}: Complete!"
      else 
        puts "No Items!"
        next
      end
    end
  end
end
