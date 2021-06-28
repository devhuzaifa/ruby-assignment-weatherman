# frozen_string_literal: true

require 'colorize'
require File.expand_path('./weather.rb', __dir__)

# this is one of the child class of weather
class MonthlyWeather < Weather
  def highest_average_temprature_of_the_month(month)
    pairs = get_data_from_file(month, 2)
    get_highest_value(pairs)
  end

  def lowest_average_temprature_of_the_month(month)
    pairs = get_data_from_file(month, 2)
    get_lowest_value(pairs)
  end

  def average_humidity_of_the_month(month)
    pairs = get_data_from_file(month, 8)
    get_highest_value(pairs)
  end

  def highest_temperature_of_days(month)
    get_data_from_file(month, 1)
  end

  def lowest_temperature_of_days(month)
    get_data_from_file(month, 3)
  end

  def draw_chart(highest_temperatures, lowest_temperatures)
    highest_temperatures_array = make_array_from_hash(highest_temperatures)
    lowest_temperatures_array = make_array_from_hash(lowest_temperatures)
    draw_chart_wrapper(highest_temperatures_array, lowest_temperatures_array)
  end

  def draw_chart_wrapper(highest_temperatures, lowest_temperatures)
    highest_temperatures.each_index do |index|
      print "#{index + 1} "
      draw_stars(highest_temperatures[index], 'red')
      puts " #{highest_temperatures[index]}C"
      print "#{index + 1} "
      draw_stars(lowest_temperatures[index], 'blue')
      puts " #{lowest_temperatures[index]}C"
    end
  end

  def draw_stars(limit, color)
    limit.to_i.times do
      print '+'.red if limit.to_i.positive? && (color == 'red')
      print '+'.blue if color == 'blue'
    end
  end

  def draw_horizontal_bar_chart(highest_temperatures, lowest_temperatures)
    highest_temperatures_array = make_array_from_hash(highest_temperatures)
    lowest_temperatures_array = make_array_from_hash(lowest_temperatures)
    draw_horizontal_bar_chart_wrapper(highest_temperatures_array, lowest_temperatures_array)
  end

  def draw_horizontal_bar_chart_wrapper(highest_temperatures, lowest_temperatures)
    highest_temperatures.each_index do |index|
      print "#{index + 1} "
      draw_stars(lowest_temperatures[index], 'blue')
      draw_stars(highest_temperatures[index], 'red')
      print " #{lowest_temperatures[index]}C - "
      puts " #{highest_temperatures[index]}C"
    end
  end

  def make_array_from_hash(pair)
    array = []
    pair.each do |_key, value|
      array << value
    end
    array
  end
end
