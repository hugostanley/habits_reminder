# frozen_string_literal: true
require 'active_support/time'
require 'json'

# Documentation
class Reminder
  attr_accessor :strings, :time_arr, :json_file

  def initialize
    @json_file = read_json_file
    @strings = @json_file['strings']
    @time_arr = @json_file['time_arr']
  end

  def random_reminder(str = @strings)
    str.sample
  end

  def read_json_file
    json_file = File.read('./reminders.json')
    JSON.parse json_file
  end

  def display_reminder
    timezone = ActiveSupport::TimeZone['Asia/Manila'] # set the timezone to 'Asia/Manila'
    loop do
      current_time_in_hours = Time.now.in_time_zone(timezone).strftime('%H')
      current_time_exists_in_array = @time_arr.include? current_time_in_hours
      system("notify-send \"Hey You!\" \"#{random_reminder}\" -t 5000") if current_time_exists_in_array
      sleep(1800)
    end
  end
end

reminder = Reminder.new
reminder.display_reminder
