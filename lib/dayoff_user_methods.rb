module DayoffUserMethods

  def self.get_total_dayoff_time
    sum = 0
    User.find(:all).each do |user|
      Dayoff.get_dayoff_types.each do |h|
        sum += user.send("max_#{h}")
      end
    end
    sum
  end

  def self.get_taken_dayoff_time
    Dayoff.all_approved.inject(0) {|sum,h| sum += h.get_length }
  end

  def get_total_dayoff_time
    this_years_dayoff.inject(0) {|sum,h| sum += h.get_length}
  end

  def get_taken_dayoff_time
    results = Dictionary.new
    Dayoff.get_dayoff_types.each {|t| results[t.to_sym] = 0.0 }
    this_years_daysoff.each do |dayoff|
      if dayoff.state == 1 and dayoff.begin_time.year >= Date.today.year
        results[dayoff.leave_type.to_sym] += dayoff.get_length 
      end
    end
    results
  end

  def get_list_of_dates
    array = []
    this_years_daysoff.each do |h|
      h.included_dates.each do |dates|
        array << dates
      end
    end
    array
  end

  def get_remaining_dayoff_time
    results = Dictionary.new
    Holiday.get_dayoff_types.each {|t| results[t.to_sym] = self.send("max_#{t}").to_f}
    this_years_daysoff.each do |dayoff|
      results[dayoff.leave_type.to_sym] -= dayoff.get_length if dayoff.state == 1
    end
    results
  end

  def this_years_daysoff
    daysoff.select {|h| h.begin_time.year >= Date.today.year}
  end

end
