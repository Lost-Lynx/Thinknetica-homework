require_relative 'module_company.rb'               #Задание 1

class Train
  include Company
  attr_reader :number                           #Задание 3
  attr_reader :route
  attr_reader :station_now
  attr_reader :carriages
  @@all = []

  #все методы ниже public, т.к. могут вызываться юзером

  # def speed_increasing(speed)
  #   @speed += speed
  #   return "Текущая скорость: #{@speed}"
  # end

  # def stop
  #   @speed = 0
  #   puts "Остановка совершена"
  # end

  def remove_carriage
    # if @speed == 0
      if carriages.count != 0
        carriages.pop
      else 
        puts "Поезд не имеет вагонов"
      end
    # else puts "Операция невозможна, поезд в движении"
    # end
  end

  def add_route(route)
    @route.stations.select{|s| s == @station_now}.first.remove_train(self) if !@route.nil?
    @route = route
    @route.stations[0].get_train(self)
    @station_now = @route.stations[0]
    puts "Маршрут добавлен"
  end

  def go_next_station
    if next_station.nil?
      puts "Движение вперед невозможно, конечная станция"
      return 
    end
    @station_now.remove_train(self)
    next_station.get_train(self)
    @station_now = next_station
  end

  def go_previous_station
    if previous_station.nil?
      puts "Движение назад невозможно, конечная станция"
      return 
    end
    @station_now.remove_train(self)
    previous_station.get_train(self)
    @station_now = previous_station
  end

  def self.find(number)
    @@all.select{|t| t.number == number}.first      #Задание 4
  end

  protected #данные методы используются только внутри класса, притом они могут использоваться в дочерних классах

  def initialize(number)
    @number = number
    @carriages = []
    # @speed = 0
    @@all.push(self)
  end

  def previous_station
    return if @route.stations[0] == @station_now
    @route.stations[@route.stations.index(@station_now) - 1]
  end

  def next_station
    @route.stations[@route.stations.index(@station_now) + 1]
  end
end
