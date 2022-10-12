require_relative 'module_instance_counter.rb'

class Station
  include InstanceCounter 

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

  def valid?                      #Задание 1
    validate!
    true
  rescue 
    false
  end

  def self.all 
    @@all
  end

  protected #методы ниже не должны вызываться юзером, но могут вызываться из дочерних классов

  def initialize(name)
    @name = name
    validate!                       #Задание 1
    @trains = []
    @@all.push(self)
    register_instance
  end

  def validate!
    raise "Uncorrect form" if @name !~ /^[A-Z]{1}[a-z]+/

  end
end
