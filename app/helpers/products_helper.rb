module ProductsHelper

  def self.get_season(week)
    week.split("/").shift(3).last
  end

  def self.get_week(week)
    week.split("/").shift(5).last
  end
  
end
