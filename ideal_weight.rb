print "Как к Вам обращаться по имени?: "
name = gets.chomp.capitalize
print "Введите свой рост: "
height = gets.to_i

ideal_weight = (height - 110) * 1.15
print "Здравствуйте, #{name}! "

if ideal_weight >=0
    print "#{ideal_weight}кг - Ваш идеальный вес "
else
    print "Ваш вес уже оптимальный "
end