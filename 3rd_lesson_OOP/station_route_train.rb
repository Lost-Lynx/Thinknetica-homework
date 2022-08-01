class Station
  attr_accessor :trains
  attr_accessor :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def trains_list
    trains.each do |train|
      puts train.number
    end
  end

  def trains_type_count(type)
    trains.each do |train|
      puts train.number if type == train.type
    end
  end

  def remove_train(train)
    trains.delete(train)
    puts "Поезд ушел со станции #{@name}"
  end

  def get_train(train)
    trains.push(train)
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
    @route.first_station.get_train(self)
    @station_now = @route.first_station
  end

  def go_next_station
    if @station_now == @route.first_station 
      if @route.middle_stations.size != 0
        @route.first_station.remove_train(self)
        @route.middle_stations[0].get_train(self)
        @station_now = @route.middle_stations[0]
      else
        @route.first_station.remove_train(self)
        @route.last_station.get_train(self)
        @station_now = @route.last_station
      end
    elsif @station_now != @route.first_station && @station_now != @route.last_station
      if @station_now != @route.middle_stations[@route.middle_stations.size - 1]
        @route.middle_stations[@route.middle_stations.index(@station_now)].remove_train(self)
        @route.middle_stations[@route.middle_stations.index(@station_now) + 1].get_train(self)
        @station_now = @route.middle_stations[@route.middle_stations.index(@station_now) + 1]
      else
        @route.middle_stations[@route.middle_stations.size - 1].remove_train(self)
        @route.last_station.get_train(self)
        @station_now = @route.last_station
      end
    elsif @station_now == @route.last_station
      puts "Движение по направлению невозможно, данная станция - конечная"
    end
  end

  def go_previous_station
    if @station_now == @route.last_station 
      if @route.middle_stations.size != 0
        @route.last_station.remove_train(self)
        @route.middle_stations[@route.middle_stations.size - 1].get_train(self)
        @station_now = @route.middle_stations[@route.middle_stations.size - 1]
      else
        @route.last_station.remove_train(self)
        @route.first_station.get_train(self)
        @station_now = @route.first_station
      end
    elsif @station_now != @route.first_station && @station_now != @route.last_station
      if @station_now != @route.middle_stations[0]
        @route.middle_stations[@route.middle_stations.index(@station_now)].remove_train(self)
        @route.middle_stations[@route.middle_stations.index(@station_now) - 1].get_train(self)
        @station_now = @route.middle_stations[@route.middle_stations.index(@station_now) - 1]
      else
        @route.middle_stations[0].remove_train(self)
        @route.first_station.get_train(self)
        @station_now = @route.first_station
      end
    elsif @station_now == @route.first_station
      puts "Движение обратно направлению невозможно, данная станция - конечная"
    end
  end

  def stations_info
    puts "Текущая станция: #{@station_now.name}"

    if @station_now == @route.first_station 
      if @route.middle_stations.size != 0
        puts "Следующая по направлению станция: #{@route.middle_stations[0].name}"
      else
        puts "Следующая по направлению станция: #{@route.last_station.name}"
      end
    elsif @station_now != @route.first_station && @station_now != @route.last_station
      if @station_now != @route.middle_stations[@route.middle_stations.size - 1]
        puts "Следующая по направлению станция: #{@route.middle_stations[@route.middle_stations.index(@station_now) + 1].name}"
      else
        puts "Следующая по направлению станция: #{@route.last_station.name}"
      end
    end

    if @station_now == @route.last_station 
      if @route.middle_stations.size != 0
        puts "Предыдущая по направлению станция: #{@route.middle_stations[@route.middle_stations.size - 1].name}"
      else
        puts "Предыдущая по направлению станция: #{@route.first_station.name}"
      end
    elsif @station_now != @route.first_station && @station_now != @route.last_station
      if @station_now != @route.middle_stations[0]
        puts "Предыдущая по направлению станция: #{@route.middle_stations[@route.middle_stations.index(@station_now) - 1].name}"
      else
        puts "Предыдущая по направлению станция: #{@route.first_station.name}"
      end
    end
  end
end
