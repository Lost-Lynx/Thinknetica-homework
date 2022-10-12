require_relative 'station.rb'
require_relative 'route.rb'
require_relative 'train.rb'
require_relative 'pass_train'
require_relative 'cargo_train'
require_relative 'pass_carriage'
require_relative 'cargo_carriage'

class Interface
  attr_accessor :stations
  attr_accessor :trains
  attr_accessor :routes

  def call
    loop do
      puts "0 - Выход \n1 - Создание станций\n2 - Создание поездов\n3 - Создание/редактирование маршрутов\n4 - Действия с поездами\n5 - Информация о станциях"
      menu_value = gets.chomp.to_i

      case menu_value
      when 0
        break
      when 1
        puts 'Введите название станции или 0 для выхода'
        station_name = gets.chomp
        break if station_name == '0'

        if stations.map(&:name).include?(station_name)
          puts 'Нельзя создать станцию с уже существующиим названием'
          next
        end
        station = Station.new(station_name)
        stations.push(station)
        puts 'Станция создана'
      when 2
        puts "Введите тип поезда: 1 - грузовой, 2 - пассажирский\nВведите 0 для выхода"
        choose = gets.chomp.to_i
        if choose != 0
          puts "Введите номер поезда"
          train_number = gets.chomp
          if train_number !~ /^[\w\d]{3}\-[\w\d]{2}$/              ###############Задание 4
            puts "Введена некорректная форма номера, повторите попытку, используя шаблон \"***-**\" (англ. символы и цифры)"
            next
          end
          train = nil
        end
        case choose
        when 0
          next
        when 1
          train = CargoTrain.new(train_number)
        when 2
          train = PassTrain.new(train_number)
        else
          puts 'Введено некорректное значение, повторите попытку'
        end
        unless train.nil?
          trains.push(train)
          puts "Поезд создан"
          next
        end
      when 3
        puts "Выберите действие с маршрутами: 1 - создать, 2 - редактировать\nВведите 0 для выхода"
        route_menu_value = gets.chomp.to_i
        case route_menu_value
        when 0
          next
        when 1
          puts "Назначьте маршруту начальную и конечную станцию из списка существующих: #{stations.map(&:name)} \nВведите 0 для выхода"
          first_station = nil
          puts 'Введите название начальной станции: '
          first_station = gets.chomp
          next if first_station == '0'

          unless stations.map(&:name).include?(first_station)
            puts 'Введенной станции в списке существующих не найдено, повторите попытку'
            next
          end
          last_station = nil
          puts 'Введите название конечной станции: '
          last_station = gets.chomp
          next if last_station == '0'

          unless stations.map(&:name).include?(last_station)
            puts 'Введенной станции в списке существующих не найдено, повторите попытку'
            next
          end
          route = Route.new(stations.select { |s| s.name == first_station }.first, stations.select { |s| s.name == last_station }.first)
          routes.push(route)
          puts 'Маршрут создан'
          next
        when 2
          route = nil
          puts "Выберите маршрут: #{routes.map { |r| "ID: #{r.id}, #{r.stations.first.name}-#{r.stations.last.name}" }}\nВведите 0 для выхода"
          puts 'Введите ID маршрута: '
          route_id = gets.chomp.to_i
          next if route_id == 0

          unless routes.map(&:id).include?(route_id)
            puts 'Введенного маршрута в списке существующих не найдено, повторите попытку'
            next
          end
          route = routes.select { |r| r.id == route_id }.first
          puts "Станции текущего маршрута: #{route.stations.map(&:name)}"
          puts "Выберите действие со станциями: 1 - добавить, 2 - удалить\nВведите 0 для выхода"
          route_edit_manu_value = gets.chomp.to_i
          case route_edit_manu_value
          when 0
            next
          when 1
            puts "Выберите станцию для добавления: #{stations.map(&:name)}\nВведите 0 для выхода"
            station_name = gets.chomp
            next if station_name == '0'

            station = stations.select { |s| s.name == station_name }.first
            if station.nil?
              puts 'Введенной станции в списке существующих не найдено, повторите попытку'
              next
            end
            route.add_station(station)
            next
          when 2
            puts "Выберите станцию для удаления: #{route.stations.map(&:name)}\nВведите 0 для выхода"
            station_name = gets.chomp
            station = stations.select { |s| s.name == station_name }.first
            if route.stations.empty?
              puts 'Введеной станции не найдено, маршрут пустой'
              next
            elsif station.nil?
              puts "Введенной станции в списке маршрута #{route.stations.first.name} - #{route.stations.last.name} не найдено, повторите попытку"
              next
            end
            route.remove_station(station)
            next
          end
        end
      when 4
        puts "Выберите поезд: #{trains.map(&:number)}\nВведите 0 для выхода"
        train_number = gets.chomp.to_i
        next if train_number == 0

        train = trains.select { |t| t.number == train_number }.first
        if train.nil?
          puts 'Введенного поезда в списке существующих не найдено, повторите попытку'
          next
        end
        puts "Выберите действие с поездом: 1 - назначение маршрута, 2 - добавление/удаление вагонов, 3 - перемещение\nВведите 0 для выхода"
        train_menu_value = gets.chomp.to_i
        case train_menu_value
        when 0
          next
        when 1
          route_id = nil
          puts "Выберите маршрут, который необходимо назначить: #{routes.map { |r| "ID: #{r.id}, #{r.stations.first.name}-#{r.stations.last.name}" }}\nВведите 0 для выхода"
          puts 'Введите ID маршрута: '
          route_id = gets.chomp.to_i
          next if route_id == 0

          unless routes.map(&:id).include?(route_id)
            puts 'Введенного маршрута в списке существующих не найдено, повторите попытку'
            next
          end
          trains.select { |t| t.number == train_number }.first.add_route(routes.select { |r| r.id == route_id }.first)
          next
        when 2
          puts "Выберите действие с вагонами: 1 - добавить, 2 - удалить\nВведите 0 для выхода"
          carriage_action = gets.chomp
          carriage = nil
          case carriage_action
          when '0'
            next
          when '1'
            if train.class == PassTrain
              carriage = PassCarriage.new
            elsif train.class == CargoTrain
              carriage = CargoCarriage.new
            else
              puts 'Нет вагонов к данному типа поезда'
              next
            end
            train.add_carriage(carriage)
          when '2'
            train.remove_carriage
          else
            puts 'Введено некорректное значение, повторите попытку'
            next
          end
          puts "Вагоны: #{trains.select { |t| t.number == train_number }.first.carriages.map { |c| "-|#{c.number}|-" }}"
          next
        when 3
          if train.route.nil?
            puts 'Маршрут у данного поезда отсутствует'
            next
          end
          puts "Выберите направление движения: 1 - вперед, 2 - назад\nВведите 0 для выхода"
          move_way = gets.chomp.to_i
          next if move_way == 0

          case move_way
          when 1
            train.go_next_station
          when 2
            train.go_previous_station
          end
          next
        else
          puts 'Введено некорректное значение, повторите попытку'
          next
        end
      when 5
        if stations != []
          puts stations.map { |s|
            trains_info = s.trains_info
            if trains_info != []
              "#{s.name}: #{trains_info}"
            else
              s.name.to_s
            end
          }
        else
          puts 'Зарегистрированные станции отсутствуют'
        end
      else puts 'Введено некорректное значение, повторите попытку'
      end
    end
  end

  protected

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end
end
