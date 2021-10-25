# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :phoneNumber, presence: true
  validates :email, presence: true
  validates :interviewDateTime, presence: true
=begin
  def self.get_dates
    # start_date = Admin.dateRange.split(/-/)[0]
    # end_date = Admin.dateRange.split(/-/)[1]
    @admins = Admin.all
    my_date = ''
    @admins.each do |a|
      my_date = a.dateRange
    end
    my_date
  end
  def self.get_times
    @admins = Admin.all
    my_time = ''
    @admins.each do |a|
      my_time = a.timeRange
    end
    # start_time = my_time.split(/-/)[0].rstrip.split("am")
    # end_time = my_time.split(/-/)[1].rstrip.split("pm")
    start_time = my_time.split(/-/)[0].rstrip
    end_time = my_time.split(/-/)[1].rstrip

    if start_time.include? 'am'
      start_time = start_time.split('am')[0]
      start_time = start_time.split(':')[0].to_i # gets the hour, and uses it as start
    elsif start_time.include? 'pm'
      start_time = start_time.split('pm')[0]
      start_time = start_time.split(':')[0].to_i + 11 # gets the hour, and uses it as start
    end

    if end_time.include? 'am'
      end_time = end_time.split('am')[0]
      end_time = end_time.split(':')[0].to_i # gets the hour, and uses it as start
    elsif end_time.include? 'pm'
      end_time = end_time.split('pm')[0]
      end_time = end_time.split(':')[0].to_i + 11 # gets the hour, and uses it as start. Plus 11 because time includes 30 minute from end time
    end

    puts(start_time)
    puts(end_time)
    [start_time, end_time]
  end
=end
  def self.list_days_and_times
    @admins = Admin.all

    my_date = ''
    num_breaks = ''
    interview_length = ''
    my_time = ''
    num_rooms = ''
    @admins.each do |a|
      my_date = a.dateRange
      num_breaks = a.numBreaks
      interview_length = a.interviewLength
      my_time = a.timeRange
      num_rooms = a.numRooms
    end

    start_date = Date.parse(my_date.split(/:/)[0].to_s)
    end_date = Date.parse(my_date.split(/:/)[1].to_s)
    date_list = (start_date..end_date).map(&:to_s) # date list finished
    # return date_list

    # time list parsing
    start_time = my_time.split(/-/)[0].rstrip
    end_time = my_time.split(/-/)[1].rstrip

    if start_time.include? 'am'
      start_time = start_time.split('am')[0]
      start_time = start_time.split(':')[0].to_i # gets the hour, and uses it as start
    elsif start_time.include? 'pm'
      start_time = start_time.split('pm')[0]
      start_time = start_time.split(':')[0].to_i + 11 # gets the hour, and uses it as start
    end

    if end_time.include? 'am'
      end_time = end_time.split('am')[0]
      end_time = end_time.split(':')[0].to_i # gets the hour, and uses it as start
    elsif end_time.include? 'pm'
      end_time = end_time.split('pm')[0]
      end_time = end_time.split(':')[0].to_i + 11 # gets the hour, and uses it as start. Plus 11 because time includes 30 minute from end time
    end

    x = start_time
    min = 0
    time_list = []
    while x <= end_time
      min = '00' if min.zero?
      if x <= 12
        if x == 12
          time_list.push("#{x}:#{min}pm")
        else
          time_list.push("#{x}:#{min}am")
        end
      else
        time_list.push("#{x - 12}:#{min}pm")
      end

      # increase minute by interview length
      min = min.to_i + interview_length.to_i
      min = 0 if min == 60
      x = if min != 0
            x
          else
            x + 1
          end
    end

    # puts (time_list)
    # return time_list

    # remove time slot every __ interviews
    # break time is equal to interview time
    break_count = 0
    i = 0

    time_list.each do |_t|
      if break_count == num_breaks.to_i
        time_list.delete_at(i)
        break_count = 0
      end
      break_count += 1
      i += 1
    end

    date_time_dict = {}
    date_list.each do |dt|
      time_list.each do |t|
        date_time_dict["#{dt},#{t}"] = num_rooms.to_i
      end
    end

    @users = User.all
    used_date_and_time = []
    @users.each do |u|
      used_date_and_time.push(u.interviewDateTime)
    end

    used_date_and_time.each do |dt|
      date_time_dict[dt] = date_time_dict[dt] - 1
    end

    final_date_time_list = []
    date_time_dict.each_key do |dt|
      final_date_time_list.push(dt) if (date_time_dict[dt]).positive?
    end

    final_date_time_list
  end
end
