class Station
  attr_accessor :trains
  attr_accessor :name

  def initialize(name)
    @name = name
    @trains = {}
  end

  def trains_list
    puts trains
  end

  def trains_type_count(type)
    trains.each do |name, train_type|
      puts name if type == train_type
    end if trains.include?(type)
  end

  def remove_train(train)
    trains.delete(train)
    puts "Поезд ушел со станции #{@name}"
  end

  def get_train(train, type)
    trains[train] = type
    puts "Поезд встал на станции #{@name}"
  end
end

class Route
  attr_accessor :first_station
  attr_accessor :last_station
  attr_reader :middle_stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @middle_stations = []
  end

  def add_station(station)
    @middle_stations.push(station)
    puts "Станция добавлена в маршрут"
  end

  def remove_station(station)
    @middle_stations.delete(station) if middle_stations.include?(station)
    puts "Станция удалена"
  end

  def stations_list
    puts @first_station.name
    @middle_stations.each do |station|
      puts station.name
    end
    puts @last_station.name
  end
end

class Train
  attr_accessor :number
  attr_accessor :type
  attr_accessor :carriage_number

  def initialize(number, type, carriage_number)
    @number = number
    @type = type
    @carriage_number = carriage_number
    @speed = 0
  end

  def speed_increasing(speed)
    @speed += speed
    puts "Текущая скорость: #{@speed}"
  end

  def stop
    @speed = 0
    puts "Остановка совершена"
  end

  def carriages_count
    puts "Количество вагонов: #{@carriage_number}"
  end

  def add_carriage(add_or_remove = true)
    if @speed == 0
      if add_or_remove 
        @carriage_number += 1
      else @carriage_number -= 1 if @carriage_number != 0
      end
    else puts "Операция невозможна, поезд в движении"
    end
  end

  def add_route(route)
    @route = route
    puts "Маршрут добавлен"
    @route.first_station.get_train(@number, @type)
    @station_now = @route.first_station
  end

  def go_next_station(forward_or_back)
    if (forward_or_back && @station_now == @route.last_station) || (!forward_or_back && @station_now == @route.first_station)
      puts "Движение в этом направлении невозможно, конечная станция"
      return
    end
    @route.middle_stations.unshift(@route.first_station)
    @route.middle_stations.push(@route.last_station)
    if forward_or_back
      @route.middle_stations.each do |station|
        if station == @station_now
          @route.middle_stations[@route.middle_stations.index(station)].remove_train(@number)
          @route.middle_stations[@route.middle_stations.index(station) + 1].get_train(@number, @type)
          @station_now = @route.middle_stations[@route.middle_stations.index(station) + 1]
          break
        end
      end
    else
      @route.middle_stations.each do |station|
        if station == @station_now
          @route.middle_stations[@route.middle_stations.index(station)].remove_train(@number)
          @route.middle_stations[@route.middle_stations.index(station) - 1].get_train(@number, @type)
          @station_now = @route.middle_stations[@route.middle_stations.index(station) - 1]
          break
        end
      end
    end
    @route.middle_stations.delete(@route.first_station)
    @route.middle_stations.delete(@route.last_station)
  end

  def stations_info
    puts "Текущая станция: #{@station_now.name}"
    @route.middle_stations.unshift(@route.first_station)
    @route.middle_stations.push(@route.last_station)
    @route.middle_stations.each do |station|
      puts "Предыдущая по направлению станция: #{@route.middle_stations[@route.middle_stations.index(station) - 1].name}" if station == @station_now && @route.middle_stations[@route.middle_stations.index(station) - 1] != @route.last_station
      puts "Следующая по направлению станция: #{@route.middle_stations[@route.middle_stations.index(station) + 1].name}" if station == @station_now && !@route.middle_stations[@route.middle_stations.index(station) + 1].nil?
    end
    @route.middle_stations.delete(@route.first_station)
    @route.middle_stations.delete(@route.last_station)
  end
end