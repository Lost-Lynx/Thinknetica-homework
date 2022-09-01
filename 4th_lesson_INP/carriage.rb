class Carriage
  attr_reader :number
  @@numbers = 0

  protected #методы ниже не должны вызываться юзером, но могут вызываться из дочерних классов

  def initialize
    @@numbers += 1
    @number = @@numbers
  end
end
