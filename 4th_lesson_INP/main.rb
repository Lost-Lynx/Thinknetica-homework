require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'pass_train'
require_relative 'cargo_train'
require_relative 'pass_carriage'
require_relative 'cargo_carriage'

stations = []
trains = []
routes = []

loop do
  puts "0 - Выход \n1 - Создать станцию\n2 - Создать поезд \n3 - Создать/редактировать маршрут \n4 - Действия с поездами \n5 - Информация о станциях"
  menu_value = gets.chomp.to_i

  case menu_value
  when 0
    break
  when 1
    puts 'Введите название станции: '
    name = gets.chomp
    station = Station.new(name)
    stations.push(station)
    puts "Станция создана"
  when 2
    loop do
      puts 'Введите тип поезда: 1 - грузовой, 2 - пассажирский, 0 - выход: '
      choose = gets.chomp.to_i
      train = nil
      case choose
        when 0
          break
        when 1
          train = CargoTrain.new(trains.size + 1)
        when 2
          train = PassTrain.new(trains.size + 1)
        else puts "Введено некорректное значение, повторите попытку"
      end
      if !train.nil?
        trains.push(train)
        puts "Поезд создан"
        break
      end
    end
  when 3
    puts "Назначьте маршруту начальную и конечную станцию из списка существующих: #{stations.map{|s| s.name}}, 0 - выход"
    loop do
      first_station = nil
      loop do
        puts 'Введите название начальной станции: '
        first_station = gets.chomp
        if stations.map{|s| s.name}.include?(first_station) || first_station == '0'
          break
        else
          puts 'Введенной станции в списке существующих не найдено, повторите попытку'
        end
      end
      break if first_station == '0'
      last_station = nil
      loop do
        puts 'Введите название конечной станции: '
        last_station = gets.chomp
        if stations.map{|s| s.name}.include?(last_station) || last_station == '0'
          break
        else
          puts 'Введенной станции в списке существующих не найдено, повторите попытку'
        end
      end
      break if last_station == '0'
      route = Route.new(stations.select{|s| s.name == first_station}.first, stations.select{|s| s.name == last_station}.first)
      routes.push(route)
      puts "Маршрут создан"
      break
    end
  when 4
    loop do
      puts "Выберите поезд: #{trains.map{|t| t.number}}, 0 - выход"
      train_number = gets.chomp.to_i
      break if train_number == 0
      train = trains.select{|t| t.number == train_number}.first
      if train.nil?
        puts 'Введенного поезда в списке существующих не найдено, повторите попытку'
        next
      end
      loop do
        puts "Выберите действие с поездом: 1 - назначить маршрут, 2 - добавление/удаление вагонов, 3 - перемещение, 0 - выход"
        train_menu_value = gets.chomp.to_i
        case train_menu_value
        when 0
          break
        when 1
          route_id = nil
          loop do
            puts "Выберите маршрут, который необходимо назначить: #{routes.map{|r| "ID: #{r.id}, #{r.stations.first.name}-#{r.stations.last.name}"}}, 0 - выход"
            puts 'Введите ID маршрута: '
            route_id = gets.chomp.to_i
            break if route_id == 0
            if !routes.map{|r| r.id}.include?(route_id)
              puts 'Введенного маршрута в списке существующих не найдено, повторите попытку'
              next
            end
            trains.select{|t| t.number == train_number}.first.add_route(routes.select{|r| r.id == route_id}.first)
            break
          end
        when 2
          loop do
            puts "Выберите действие с вагонами: 1 - добавить, 2 - удалить, 0 - выход"
            carriage_action = gets.chomp
            carriage = nil
            case carriage_action
            when '0' 
              break
            when '1'
              if train.class == PassTrain
                carriage = PassCarriage.new
              elsif train.class == CargoTrain
                carriage = CargoCarriage.new
              else
                puts "Нет вагонов к данному типа поезда"
                break
              end
              train.add_carriage(carriage)
            when '2'
              train.remove_carriage
            else
              puts "Введено некорректное значение, повторите попытку"
              next
            end
            puts "Вагон добавлен: #{trains.select{|t| t.number == train_number}.first.carriages.map{|c| "-|#{c.number}|-"}}"
          end
        when 3
          loop do
            if train.route.nil?
              puts "Маршрут у данного поезда отсутствует"
              break
            end
            puts "Выберите направление движения: 1 - вперед, 2 - назад, 0 - выход"
            move_way = gets.chomp.to_i
            break if move_way == 0
            case move_way
            when 1
              train.go_next_station
            when 2
              train.go_previous_station
            end
          end
        else puts "Введено некорректное значение, повторите попытку"
        end
      end
    end
  when 5
    if stations != []
      puts stations.map{|s| 
        trains_info = s.trains_info
        if trains_info != []
          "#{s.name}: #{trains_info}"
        else 
          "#{s.name}"
        end
      }
    else
      puts "Зарегистрированные станции отсутствуют"
    end
  else puts "Введено некорректное значение, повторите попытку"
  end
end
