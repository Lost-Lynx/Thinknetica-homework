class Station
  attr_reader :name
  attr_reader :trains

  #все методы ниже public, т.к. могут вызываться юзером

  def trains_info
    return trains.map{|t| 
      if !t.route.nil?
        "##{t.number} (#{t.route.stations.first.name} - #{t.route.stations.last.name})" 
      else
        "##{t.number}"
      end
    }
  end

  def remove_train(train)
    @trains.delete(train)
    puts "Поезд ##{train.number} ушел со станции #{@name}"
  end

  def get_train(train)
    @trains.push(train)
    puts "Поезд ##{train.number} встал на станции #{@name}"
  end

  protected #методы ниже не должны вызываться юзером, но могут вызываться из дочерних классов

  def initialize(name)
    @name = name
    @trains = []
  end
end
