require_relative 'train.rb'

class CargoTrain < Train
  
  def add_carriage(carriage)
      # if @speed == 0
    if carriage.class == CargoCarriage
      carriage.set_number(@carriages.count + 1)
      @carriages.push(carriage)
      # else puts "Операция невозможна, поезд в движении"
      # end
    else  
      puts "Поезд может содержать только грузовые вагоны"
    end
  end
end
