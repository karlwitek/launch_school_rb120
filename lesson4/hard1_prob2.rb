module TravelDistance
  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include TravelDistance

  attr_accessor :speed, :heading

  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicle

  def initialize
    super(50, 25.0)
    @tires = [30, 30, 32, 32]
  end
end

class Motorcycle < WheeledVehicle

  def initialize
    super(80, 8.0)
    @tires = [20, 20]
  end
end

class Catamaran < WheeledVehicle

  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    super(km_traveled_per_liter, liters_of_fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
  end
end

my_auto = Auto.new
puts my_auto.range# 1250.0
my_motorcycle = Motorcycle.new
puts my_motorcycle.range# 640.0

my_cat = Catamaran.new(4, 6, 90, 10)
puts my_cat.range# 900

puts my_auto.tire_pressure(2)# 32
my_auto.inflate_tire(2, 67)
puts my_auto.tire_pressure(2)# 67

puts my_cat.hull_count# 6



  
