# frozen_string_literal: true

require 'date'
require 'colorize'
require File.expand_path('./monthly_weather.rb', __dir__)
require File.expand_path('./yearly_weather.rb', __dir__)

# Driver Class for weatherman project
class Driver
  def yearly_weather
    yearly_weather = YearlyWeather.new
    yearly_weather.highest_temparature_of_the_year(ARGV[1])
    yearly_weather.lowest_temperature_of_the_year(ARGV[1])
    yearly_weather.highest_humidity_of_the_year(ARGV[1])
    yearly_weather.output_highest_temparature_of_the_year
    yearly_weather.output_highest_humidity_of_the_year
    yearly_weather.output_lowest_temparature_of_the_year
  end

  def monthly_weather
    monthly_weather = MonthlyWeather.new
    highest_average_of_month = monthly_weather.highest_average_temprature_of_the_month(file_path)
    lowest_average_of_month = monthly_weather.lowest_average_temprature_of_the_month(file_path)
    average_humidity_of_month = monthly_weather.average_humidity_of_the_month(file_path)
    puts "#{month_name} #{year}"
    puts "Highest Average: #{highest_average_of_month}C"
    puts "Lowest Average: #{lowest_average_of_month}C"
    puts "Average Humidity: #{average_humidity_of_month}%"
  end

  def month_name
    array = ARGV[1].split('/')
    Date::MONTHNAMES[array[1].to_i]
  end

  def year
    array = ARGV[1].split('/')
    array[0]
  end

  def file_path
    array1 = ARGV[1].split('/')
    array2 = ARGV[2].split('/')
    month_name = array1[1]
    month_name = Date::MONTHNAMES[month_name.to_i]
    month_name_short = month_name[0..2] if month_name.class != NilClass
    "./#{array2[1]}/#{array2[2]}/#{array2[2]}_#{array1[0]}_#{month_name_short}.txt"
  end

  def draw_chart_for_month
    monthly_weather = MonthlyWeather.new
    ht = monthly_weather.highest_temperature_of_days(file_path)
    lt = monthly_weather.lowest_temperature_of_days(file_path)
    monthly_weather.draw_chart(ht, lt)
  end

  def draw_bar_chart_for_month
    monthly_weather = MonthlyWeather.new
    ht = monthly_weather.highest_temperature_of_days(file_path)
    lt = monthly_weather.lowest_temperature_of_days(file_path)
    monthly_weather.draw_horizontal_bar_chart(ht, lt)
  end
end
