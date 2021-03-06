module ProductsHelper

  def self.get_season(week)
    newWeek = week.split("/").shift(3).last
    fLetter = newWeek.split("-")[0].chars[0]
    lLetter = newWeek.split("-")[1].split(/[^A-Za-z]/)[0].chars[0]
    year = newWeek.split("-")[1].split(/[^0-9]/).reject(&:empty?)
    "#{fLetter.capitalize}#{lLetter.capitalize}#{year[0]}"
  end
  
  def self.full_label(week)
    newWeek = week.split("/").reject(&:empty?)
    season = self.get_season(newWeek[1])
    "#{newWeek[0].capitalize}: #{season} :: Drop: #{newWeek.last}"
  end

  def self.get_week(week)
    week.split("/").shift(5).last
  end
  
end
