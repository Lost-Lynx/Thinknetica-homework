require_relative 'train.rb'

class PassTrain < Train

  def add_carriage(carriage)
      # if @speed == 0
    if carriage.class == PassCarriage
      carriage.set_number(@carriages.count + 1)
      @carriages.push(carriage)
      # else puts "Операция невозможна, поезд в движении"
      # end
    else  
      puts "Поезд может содержать только пассажирские вагоны"
    end
  end
end
