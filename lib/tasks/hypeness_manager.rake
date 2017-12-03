namespace :hypeness_manager do
  desc "Upgrade Single Product"
  task update_single_prod: :environment do
    require 'open-uri'
    prods = Product.where(hype_price: 0.0)
    prods.each do |prod|
      doc = Nokogiri::HTML(open(URI.parse(URI.encode("https://www.ebay.com/sch/i.html?LH_BIN=1&_ipg=100&rt=nc&_nkw=#{prod[:name].gsub(" ", "+")}"))))
      prices = []  
      print "Progress: "
      
      # Pull numbers from each product
      doc.css('.sresult').first(5).each do |result|
        price = result.css('.gvprices span span').text()
        shipping = result.css('.lvshipping span span').text()
        
        price = if price.split(" to ").count > 1
          f = price.split("to")[0]
          l = price.split("to")[2]
          (f.gsub(/[^0-9]/, '').to_f / 100 + l.gsub(/[^0-9]/, '').to_f / 100)  / 2
        elsif price.split(" to ").count == 1
          price.split("Previous Price")[0].gsub(/[^0-9]/, '').to_f / 100
        else
          price.gsub(/[^0-9]/, '').to_f / 100
        end
        
        shipping = (shipping.gsub(/[^0-9]/, '').to_i / 100.00)
        prices << price + shipping
      end
      
      average = prices.sum.to_f / prices.length.to_f
      prod.hype_price = ('%.2f' % average).to_f
      
      prod.hype = if prod.hype_price.to_f.between?(40.0, 89.9)
        "Not That Hype"
      elsif prod.hype_price.to_f.between?(90.0, 149.9)
        "Pretty Hype"
      elsif prod.hype_price.to_f > 150
        "HYPE AF"
      end
      
      puts "\nResell Price: #{prod.hype_price}"
      prod.save
      puts "\nResult Scan Complete\n"
    end
  end
  
  desc "TODO"
  task update_hypeness: :environment do
    require 'open-uri'
    puts "Welcome to Product HYPENESS Updater"
    averages = []
    
    # Ebay each of the products
    Product.all.each do |prod|
      puts "\n======================================="
      puts "Product: #{prod.name}"
      puts "=======================================\n"
      
      # Document holding each product result list
      doc = Nokogiri::HTML(open(URI.parse(URI.encode("https://www.ebay.com/sch/i.html?LH_BIN=1&_ipg=100&rt=nc&_nkw=#{prod[:name].gsub(" ", "+")}"))))
      prices = []  
      print "Progress: "
      
      # Pull numbers from each product
      doc.css('.sresult').first(5).each do |result|
        price = result.css('.lvprice span').text()
        shipping = result.css('.lvshipping span span').text()
        
        price = if price.split(" to ").count > 1
          f = price.split("to")[0]
          l = price.split("to")[2]
          (f.gsub(/[^0-9]/, '').to_f / 100 + l.gsub(/[^0-9]/, '').to_f / 100)  / 2
        elsif price.split(" to ").count == 1
          price.split("Previous Price")[0].gsub(/[^0-9]/, '').to_f / 100
        else
          price.gsub(/[^0-9]/, '').to_f / 100
        end
        
        shipping = (shipping.gsub(/[^0-9]/, '').to_i / 100.00)
        prices << price + shipping
      end
      
      average = prices.sum.to_f / prices.length.to_f
      prod.hype_price = ('%.2f' % average).to_f
      
      prod.hype = if prod.hype_price.to_f.between?(40.0, 89.9)
        "Not That Hype"
      elsif prod.hype_price.to_f.between?(90.0, 149.9)
        "Pretty Hype"
      elsif prod.hype_price.to_f > 150
        "HYPE AF"
      end
      
      puts "\nResell Price: #{prod.hype_price}"
      prod.save
      puts "\nResult Scan Complete\n"
    end
  end
end
