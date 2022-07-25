months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts 'Введите день: '
day = gets.chomp.to_i
puts 'Введите месяц: '
month = gets.chomp.to_i
puts 'Введите год: '
year = gets.chomp.to_i

if year % 4 == 0
  visokosniy = true
  visokosniy = false if year % 100 == 0 && year % 400 != 0
  if visokosniy
    puts 'Данный год является високосным'
    months[1] = 29 if month > 1 || (month == 1 && day == 29)
  end
end

date_position = 0
month_position = 0
months.each do |month_days|
  month_position += 1
  if month_position == month
    date_position += day
    break
  end
  date_position += month_days
end

puts "Порядковый номер введенной даты в #{year}-ом году: #{date_position}"
