require 'date'
require 'active_support'
require 'active_support/core_ext'
require 'holidays'

class Cohort

  FIRST_COFFEE_CODE_WEEK = 3
  LAST_COFFEE_CODE_WEEK = 10
  WEEKS_IN_COHORT = 10


  def initialize(first_day)
    @first_day = first_day
  end

  def last_day
    @first_day + (WEEKS_IN_COHORT - 1).weeks + 4.days
  end

  def no_lecture_on(day)
    day.saturday? || day.sunday? || day.to_date == Date.new(2017,07,03) || double_check_holiday(day)
  end

  def double_check_holiday(day)
    potential_holidays = Holidays.on(day, :ca_on)

    if potential_holidays.any?
      potential_holidays.each do |h|
        print "Are you taking #{h} off? y/N: "
        answer = gets.chomp
        if answer.downcase == 'y'
          return true
        end
      end
    end

    return false
  end

  def class_days
    @class_days ||= []

    if @class_days.empty?
      (@first_day..last_day).each do |day|
        unless no_lecture_on(day)
          @class_days << day
        end
      end
    end

    return @class_days
  end

  def weeks_of_cohort
    (@first_day..last_day).each_slice(7)
  end

  def week_of(day)
    week_number = 1
    weeks_of_cohort.each do |week|
      if week.include?(day)
        return week_number
      end

      week_number += 1
    end

    return nil
  end

  def coffee_code_day?(day)
    day.tuesday? || day.thursday?
  end

  def coffee_code_week?(day)
    week_of(day).between?(FIRST_COFFEE_CODE_WEEK, LAST_COFFEE_CODE_WEEK)
  end

  def coffee_code_days
    list = []

    class_days.each do |day|
      if coffee_code_week?(day) && coffee_code_day?(day)
        list << day
      end
    end

    return list
  end

end


walle = Cohort.new(Date.new(2017,10,23))
puts walle.coffee_code_days
# 2017-11-07
# 2017-11-09
# 2017-11-14
# 2017-11-16
# 2017-11-21
# 2017-11-23
# 2017-11-28
# 2017-11-30
# 2017-12-05
# 2017-12-07
# 2017-12-12
# 2017-12-14
# 2017-12-19
# 2017-12-21
# 2017-12-28

puts walle.class_days
# 2017-10-23
# 2017-10-24
# 2017-10-25
# 2017-10-26
# 2017-10-27
# 2017-10-30
# 2017-10-31
# 2017-11-01
# 2017-11-02
# 2017-11-03
# 2017-11-06
# 2017-11-07
# 2017-11-08
# 2017-11-09
# 2017-11-10
# 2017-11-13
# 2017-11-14
# 2017-11-15
# 2017-11-16
# 2017-11-17
# 2017-11-20
# 2017-11-21
# 2017-11-22
# 2017-11-23
# 2017-11-24
# 2017-11-27
# 2017-11-28
# 2017-11-29
# 2017-11-30
# 2017-12-01
# 2017-12-04
# 2017-12-05
# 2017-12-06
# 2017-12-07
# 2017-12-08
# 2017-12-11
# 2017-12-12
# 2017-12-13
# 2017-12-14
# 2017-12-15
# 2017-12-18
# 2017-12-19
# 2017-12-20
# 2017-12-21
# 2017-12-22
# 2017-12-25
# 2017-12-26
# 2017-12-27
# 2017-12-28
# 2017-12-29
