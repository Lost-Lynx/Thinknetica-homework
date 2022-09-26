require_relative 'module_instance_counter.rb'

class Station
  include InstanceCounter###Задание 5 - не доделано: не знаю как сделать так,
                          ### чтобы в метод instances прилетала переменная класса, чтобы выводить этот метод без параметра, вот так - Station.instances,
                          ### только если в самом классе создавать отдельный метод, чтобы вызывать этот метод в модуле с параметром,
                          ### но, мне кажется, проще этот метод в модуле вообще не иметь

  attr_reader :name
  attr_reader :trains
  @@all = []

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

  def self.all                 #Задание 2
    @@all
  end

  protected #методы ниже не должны вызываться юзером, но могут вызываться из дочерних классов

  def initialize(name)
    @name = name
    @trains = []
    @@all.push(self)
    register_instance
  end
end
