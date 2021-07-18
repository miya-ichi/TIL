require 'date'

MONTH = ['Janualy', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
today = Date.today
first_day = Date.new(today.year, today.month, 1)
last_day = Date.new(today.year, today.month, -1)
calender = [[], [], [], [], [], []]# カレンダーの日付を格納するための配列
start = first_day.wday # 配列に格納する1日目の曜日を指定

i = 1 # 配列に格納するための日付
6.times do |n|
    start.upto(6) do |m|
        if i <= last_day.day
            calender[n][m] = i
        end
        i += 1
    end
    start = 0
end

puts "#{MONTH[today.month - 1]} #{today.year.to_s}".center(20)
puts "Su Mo Tu We Th Fr Sa"
6.times do |n|
    puts format("%2s %2s %2s %2s %2s %2s %2s", calender[n][0], calender[n][1], calender[n][2], calender[n][3], calender[n][4], calender[n][5], calender[n][6])
end
