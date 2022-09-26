require_relative 'module_company.rb'            #Задание 1

class Carriage
  include Company
  attr_reader :number
  @@numbers = 0

  def set_number(number)
    @number = number
  end

  protected #методы ниже не должны вызываться юзером, но могут вызываться из дочерних классов

  def initialize
    @@numbers += 1
    @number = @@numbers
  end
end
