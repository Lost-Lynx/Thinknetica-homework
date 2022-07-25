products = {}
loop do
  puts '0 - Выход'
  puts '1 - Добавить или изменить товар'
  puts '2 - Показать корзину товаров'
  puts '3 - Показать итоговую сумму товаров в корзине'
  menu_value = gets.chomp.to_i

  case menu_value
  when 0
    break
  when 1
    loop do
      puts 'Введите название товара: '
      product_name = gets.chomp
      break if product_name == 'Стоп' || product_name == 'стоп'
      puts 'Введите цену за единицу: '
      product_price = gets.chomp.to_f
      puts 'Введите количество товара: '
      product_count = gets.chomp.to_f

      products[product_name] = { product_count => product_price }
      puts 'Товар успешно добавлен'
      puts "Введите далее 'Стоп' для завершения добавления товаров"
    end
  when 2
    puts products
    products.each do |name, values|
      sum = 0
      values.each do |count, price|
        sum = count * price
      end
      puts "Итоговая цена '#{name}': #{sum}"
    end
  when 3
    sum = 0
    products.each do |_name, values|
      values.each do |count, price|
        sum += count * price
      end
    end
    puts "Итоговая цена покупок: #{sum}"
  else puts 'Введено некорректное число, повторите попытку'
  end
end
