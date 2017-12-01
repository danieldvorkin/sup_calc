class RestocksController < ApplicationController
  def index
    @data = []
    keepLoopin = true
    count = 1
    while(keepLoopin && count < 3)
      puts "Starting Page: #{count}"
      doc = Nokogiri::HTML(open("https://www.supremecommunity.com/restocks/us#{count == 1 ? '' : "/#{count}"}"))
      items = doc.css('.restock-item')

      items.each_with_index do |item, index|
        restocked = Time.zone.parse(item.css('.restock-time small time').attr('datetime').value)
        restock_msg = "about #{TimeDifference.between(Time.zone.now, restocked).humanize} ago"

        if items.size == 0
          keepLoopin = false
          next
        else
          @data << {
            item.css('.user-detail h5').text() => {
              color: item.attr('data-itemcolor'),
              sup_link: item.attr('data-itemid'),
              size: item.css('.user-detail .restock-colorway').text().split(" ")[3],
              time: restock_msg,
              img: item.css('.avatar img').attr('data-src').value.gsub("//", ""),
              page: count
            }.with_indifferent_access
          }
        end
      end
      keepLoopin ? Thread.new { count += 1; puts "Page #{count - 1}: Complete!" } : next
    end
  end

end
