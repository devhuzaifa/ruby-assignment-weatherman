# frozen_string_literal: true

require File.expand_path('./weatherman.rb', __dir__)

case ARGV[0]
when '-e'
  Driver.new.yearly_weather
when '-a'
  Driver.new.monthly_weather
when '-c'
  Driver.new.draw_chart_for_month
when '-b'
  Driver.new.draw_bar_chart_for_month
else
  puts 'Invalid Input!'
end
