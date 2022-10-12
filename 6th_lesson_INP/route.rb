require_relative 'module_instance_counter.rb'

class Route
  include InstanceCounter                    ###Задание 5
  
  attr_accessor :stations
  attr_reader :id
  @@count = 0

  #все методы ниже public, т.к. могут вызываться юзером

  def add_station(station)
    if !@stations.include?(station)
      @stations.insert(@stations.size - 1, station)
      puts "Станция добавлена в маршрут #{@stations.first.name} - #{@stations.last.name}"
    else
      puts "Введенная станция уже существует в маршруте: #{@stations.map{|s| s.name}}"
      return nil
    end
  end

  def remove_station(station)
    @stations.delete(station)
    puts "Станция удалена из маршрута: #{@stations.first.name} - #{@stations.last.name}"
  end

  def stations_list
    puts @stations.map{|station| station.name}
  end

  def valid?                      #Задание 1
    validate!
    true
  rescue 
    false
  end

  protected #методы ниже не должны вызываться юзером, но могут вызываться из дочерних классов

  def initialize(first_station, last_station)
    @@count += 1
    @id = @@count
    @stations = [first_station, last_station]
    validate!                       #Задание 1
    register_instance
  end

  def validate!
    raise "Uncorrect form" if @stations.first !~ /^[A-Z]{1}[a-z]+/ || @stations.last !~ /^[A-Z]{1}[a-z]+/

  end
end
