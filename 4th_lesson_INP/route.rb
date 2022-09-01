class Route
  attr_accessor :stations
  attr_reader :id
  @@count = 0

  #все методы ниже public, т.к. могут вызываться юзером

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

  protected #методы ниже не должны вызываться юзером, но могут вызываться из дочерних классов

  def initialize(first_station, last_station)
    @@count += 1
    @id = @@count
    @stations = [first_station, last_station]
  end
end
