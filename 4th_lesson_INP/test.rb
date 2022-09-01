# require_relative 'station.rb'
# require_relative 'route.rb'
# require_relative 'train.rb'
# require_relative 'pass_train'
# require_relative 'cargo_train'
# require_relative 'pass_carriage'
# require_relative 'cargo_carriage'

# stations = []
# trains = []
# routes = []

# loop do
#   puts '0 - Выход'
#   puts '1 - Создать станцию'
#   puts '2 - Создать поезд'
#   puts '3 - Создать/редактировать маршрут'
#   puts '4 - Назначить маршрут поезду'
#   puts '5 - Добавление/удаление вагонов поездов'
#   puts '6 - Перемещение поездов'
#   puts '7 - Просмотр списка станций и поездов на станции'
#   menu_value = gets.chomp.to_i

#   case menu_value
#   when 0
#     break
#   when 1
#     puts 'Введите название станции: '
#     name = gets.chomp
#     station = Station.new(name)
#     stations.push(station)
#     puts stations.map{|s| s.name}
#   when 2
#     loop do
#       puts 'Введите тип поезда: 1 - грузовой, 2 - пассажирский, 0 - выход: '
#       choose = gets.chomp.to_i
#       train = nil
#       case choose
#         when 0
#           break
#         when 1
#           train = CargoTrain.new(trains.size + 1)
#         when 2
#           train = PassTrain.new(trains.size + 1)
#         else puts 'Команда не распознана'
#       end
#       if !train.nil?
#         trains.push(train)
#         puts trains.map{|t| t.number}
#         break
#       end
#     end
#   when 3
#     puts "Назначьте маршруту начальную и конечную станцию из списка существующих: #{stations.map{|s| s.name}}, 0 - выход"
#     loop do
#       first_station = nil
#       loop do
#         puts 'Введите название начальной станции: '
#         first_station = gets.chomp
#         if stations.map{|s| s.name}.include?(first_station) || first_station == '0'
#           break
#         else
#           puts 'Введенной станции в списке существующих не найдено, повторите попытку'
#         end
#       end
#       break if first_station == '0'
#       last_station = nil
#       loop do
#         puts 'Введите название конечной станции: '
#         last_station = gets.chomp
#         if stations.map{|s| s.name}.include?(last_station) || last_station == '0'
#           break
#         else
#           puts 'Введенной станции в списке существующих не найдено, повторите попытку'
#         end
#       end
#       break if last_station == '0'
#       route = Route.new(stations.select{|s| s.name == first_station}.first, stations.select{|s| s.name == last_station}.first)
#       routes.push(route)
#       puts routes.map{|r| r.id}
#       break
#     end
#   when 4
#     loop do
#       train_number = nil
#       loop do
#         puts "Выберите поезд, которому необходимо назначить маршрут: #{trains.map{|t| t.number}}, 0 - выход"
#         train_number = gets.chomp.to_i
#         if trains.map{|t| t.number}.include?(train_number) || train_number == 0
#           break
#         else
#           puts 'Введенного поезда в списке существующих не найдено, повторите попытку'
#         end
#       end
#       break if train_number == 0
#       route_id = nil
#       loop do
#         puts "Выберите маршрут, который необходимо назначить: #{routes.map{|r| "ID: #{r.id}, #{r.stations.first.name}-#{r.stations.last.name}"}}, 0 - выход"
#         puts 'Введите ID маршрута: '
#         route_id = gets.chomp.to_i
#         if routes.map{|r| r.id}.include?(route_id) || route_id == 0
#           break
#         else
#           puts 'Введенного маршрута в списке существующих не найдено, повторите попытку'
#         end
#       end
#       break if route_id == 0
#       trains.select{|t| t.number == train_number}.first.add_route(routes.select{|r| r.id == route_id}.first)
#       break
#     end
#   when 5
#     loop do
#       train_number = nil
#       loop do
#         puts "Выберите поезд, к которому необходимо добавить/удалить вагон: #{trains.map{|t| t.number}}, 0 - выход"
#         train_number = gets.chomp.to_i
#         if trains.map{|t| t.number}.include?(train_number) || train_number == 0
#           break
#         else
#           puts 'Введенного поезда в списке существующих не найдено, повторите попытку'
#         end
#       end
#       break if train_number == 0
#       loop do
#         puts "Выберите действие с вагонами: 1 - добавить, 2 - удалить, 0 - выход"
#         carriage_action = gets.chomp
#         break if carriage_action == '0'
#         train = trains.select{|t| t.number == train_number}.first
#         carriage = nil
#         if carriage_action == '1'
#           if train.class == PassTrain
#             carriage = PassCarriage.new
#           elsif train.class == CargoTrain
#             carriage = CargoCarriage.new
#           else
#             puts "Нет вагонов к данному типа поезда"
#             break
#           end
#           train.add_carriage(carriage)
#         elsif carriage_action == '2'
#           train.remove_carriage
#         else
#           puts "Введено некорректное значение, повторите попытку"
#         end
#         puts trains.select{|t| t.number == train_number}.first.carriages.map{|c| c.number}
#       end
#     end
#   when 6
#     loop do
#       train = nil
#       train_number = nil
#       loop do 
#         puts "Выберите поезд: #{trains.map{|t| t.number}}, 0 - выход"
#         train_number = gets.chomp.to_i
#         if trains.map{|t| t.number}.include?(train_number) || train_number == 0
#           break
#         else
#           puts 'Введенного поезда в списке существующих не найдено, повторите попытку'
#         end
#       end
#       break if train_number == 0
#       train = trains.select{|t| t.number == train_number}.first
#       if train.route.nil?
#         puts "Маршрут у данного поезда отсутствует"
#         next
#       end
#       puts "Выберите направление движения: 1 - вперед, 2 - назад, 0 - выход"
#       move_way = gets.chomp.to_i
#       break if move_way == 0
#       case move_way
#       when 1
#         train.go_next_station
#       when 2
#         train.go_previous_station
#       else
#         puts "Введено некорректное значение, повторите попытку"
#       end
#     end
#   end
# end
