class Station
  attr_reader :name
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains_type_count(type)
    @trains.select{|train| train.type == type}
  end

  def remove_train(train)
    @trains.delete(train)
    puts "Поезд ушел со станции #{@name}"
  end

  def get_train(train)
    @trains.push(train)
    puts "Поезд встал на станции #{@name}"
  end
end

class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add_station(station)
    @stations.insert(@stations.size - 1, station)
    puts "Станция добавлена в маршрут"
  end

  def remove_station(station)
    @stations.delete(station) if middle_stations.include?(station)
    puts "Станция удалена"
  end

  def stations_list
    puts @stations.map{|station| station.name}
  end
end

class Train
  attr_reader :number
  attr_reader :type
  attr_reader :carriage_number
  attr_reader :station_now

  def initialize(number, type, carriage_number)
    @number = number
    @type = type
    @carriage_number = carriage_number
    @speed = 0
  end

  def speed_increasing(speed)
    @speed += speed
    return "Текущая скорость: #{@speed}"
  end

  def stop
    @speed = 0
    puts "Остановка совершена"
  end

  def carriage_number
    return "Количество вагонов: #{@carriage_number}"
  end

  def add_carriage
    if @speed == 0
      @carriage_number += 1
    else puts "Операция невозможна, поезд в движении"
    end
  end

  def remove_carriage
    if @speed == 0
      @carriage_number -= 1
    else puts "Операция невозможна, поезд в движении"
    end
  end

  def add_route(route)
    @route = route
    puts "Маршрут добавлен"
    @route.stations[0].get_train(self)
    @station_now = @route.stations[0]
  end

  def previous_station
    return if @route.stations[0] == @station_now
    @route.stations[@route.stations.index(@station_now) - 1]
  end

  def next_station
    @route.stations[@route.stations.index(@station_now) + 1]
  end

  def go_next_station
    return if next_station.nil?
    @station_now.remove_train(self)
    next_station.get_train(self)
    @station_now = next_station
  end

  def go_previous_station
    return if previous_station.nil?
    @station_now.remove_train(self)
    previous_station.get_train(self)
    @station_now = previous_station
  end
end
