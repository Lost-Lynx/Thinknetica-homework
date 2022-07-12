include Math

print "Введите коэф-нт перед x**2: "
a = gets.to_i
print "Введите коэф-нт перед x: "
b = gets.to_i
print "Введите свободный коэф-нт: "
c = gets.to_i

d = b**2 - 4 * a * c

if d > 0
    begin
        x1 = 0.5 * (-b + sqrt(d)) * 1 / a
        x2 = 0.5 * (-b - sqrt(d)) * 1 / a
        print "Уравнение имеет корни: #{x1} и #{x2} "
    end
elsif d == 0
    begin
        x = 0.5 * -b * 1 / a
        print "Уравнение имеет равные корни: #{x} "
    end
else 
    print "Корни являются мнимыми числами "
end
