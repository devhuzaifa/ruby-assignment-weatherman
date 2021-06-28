# frozen_string_literal: true

require 'colorize'
# Parent Class Weather
class Weather
  def months
    %w[January February March April May June July August September October November
       December]
  end

  def number_of_months
    12
  end

  def open_file(file_path, mode)
    @file = File.open(file_path, mode)
  end

  def close_file
    @file.close
  end

  def get_data_from_file(file_path, field)
    pair = {}
    return pair unless File.exist?(file_path)

    open_file(file_path, @mode)
    @file.drop(1).each do |line|
      next if line[0] == 'P' || line[0] == '<'

      splitted = line.split(',')
      pair[splitted[0]] = splitted[field.to_i]
    end
    close_file

    pair
  end

  def get_highest_value(pair)
    highest_temp = 0
    pair.each do |_kay, value|
      highest_temp = value.to_i unless highest_temp > value.to_i
    end
    highest_temp
  end

  def get_highest_value_pair(pairs)
    highest_temp = 0
    pair_highest = {}
    pairs.each do |key, value|
      if highest_temp < value.to_i
        highest_temp = value.to_i
        pair_highest = { key => value }
      end
    end
    pair_highest
  end

  def get_lowest_value_pair(pairs)
    lowest_temp = 100
    pair_lowest = {}
    pairs.each do |key, value|
      next if key[0] == 'P' || key[0] == '<'

      if lowest_temp > value.to_i
        lowest_temp = value.to_i
        pair_lowest = { key => value }
      end
    end
    pair_lowest
  end

  def get_lowest_value(pair)
    lowest_temp = 100
    pair.each do |_kay, value|
      lowest_temp = value.to_i if lowest_temp > value.to_i && value.to_i != 0
    end
    lowest_temp
  end
end
