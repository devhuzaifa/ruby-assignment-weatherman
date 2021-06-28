# frozen_string_literal: true

require 'date'
require 'colorize'
require File.expand_path('./weather.rb', __dir__)
# a child class of weather
class YearlyWeather < Weather
  def initialize
    super
    @highest_humid = 0
    @highest_humid_day = 0
    @highest_humid_month = 0

    @highest_temp = 0
    @highest_temp_day = 0
    @highest_temp_month = 0

    @lowest_temp = 100
    @lowest_temp_day = 0
    @lowest_temp_month = 0
  end

  def make_file_path(year, month_number)
    array = ARGV[2].split('/')
    month_name = Date::MONTHNAMES[month_number]
    "#{ARGV[2]}/#{array[2]}_#{year}_#{month_name[0..2]}.txt"
  end

  def highest_temparature_of_the_year(year)
    months.each_index do |index|
      pairs = get_data_from_file(make_file_path(year, index.next.to_i), 1)
      pair = get_highest_value_pair(pairs)
      next unless pair.values[0].to_i >= @highest_temp

      @highest_temp = pair.values[0].to_i
      @highest_temp_day = pair.keys[0]
      @highest_temp_month = index.next
    end
  end

  def highest_humidity_of_the_year(year)
    months.each_index do |index|
      pairs = get_data_from_file(make_file_path(year, index.next.to_i), 7)
      pair = get_highest_value_pair(pairs)
      next unless pair.values[0].to_i > @highest_humid

      @highest_humid = pair.values[0].to_i
      @highest_humid_day = pair.keys[0]
      @highest_humid_month = index.next
    end
  end

  def lowest_temperature_of_the_year(year)
    months.each_index do |index|
      pairs = get_data_from_file(make_file_path(year, index.next.to_i), 3)
      pair = get_lowest_value_pair(pairs)
      next unless pair.values[0].to_i <= @lowest_temp

      @lowest_temp = pair.values[0].to_i
      @lowest_temp_day = pair.keys[0]
      @lowest_temp_month = index.next
    end
  end

  def number_to_month(number)
    Date::MONTHNAMES[number.to_i]
  end

  def output_highest_temparature_of_the_year
    month = number_to_month(@highest_temp_month.to_i)
    puts "Highest: #{@highest_temp}C on #{month} #{Date.parse(@highest_temp_day).day}"
  end

  def output_highest_humidity_of_the_year
    month = number_to_month(@highest_humid_month.to_i)
    puts "Humidity: #{@highest_humid}% on #{month} #{Date.parse(@highest_humid_day).day}"
  end

  def output_lowest_temparature_of_the_year
    month = number_to_month(@lowest_temp_month.to_i)
    puts "Lowest: #{@lowest_temp}C on #{month} #{Date.parse(@lowest_temp_day).day}"
  end
end
