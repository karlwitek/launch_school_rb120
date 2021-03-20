# LS: We can move anything shared with the catamaran and wheeled vehicles into a new module(Moveable) that
# we include in both individual classes.
# Also, in the initializers of the classes that include the Moveable module, we must reference the setter
# methods that have been defined in Moveable(fuel capacity and efficiency) using self. notation. Otherwise,
# it would be interpreted as setting local variables that will lose their scope as soon as the initializers 
# return.

module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Catamaran
  include Moveable

  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
    @propeller_count = num_propellers
    @hull_count = num_hulls
  end
end

class Motorboat < Catamaran
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    @propeller_count = 1
    @hull_count = 1
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end
end
# class Motorboat not implemented correctly according to LS solution: 

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

# The definitions of Auto and Motorcycle can remain unchanged, since they both inherit from WheeledVehicle
# and we've moved any code shared between Catamaran and WheeledVehicle to the Moveable module.

car = Auto.new
puts car.range# 1250.0

my_cat = Catamaran.new(6, 4, 50, 10.0)
puts my_cat.range# 500.0
puts my_cat.propeller_count# 6

motorbike = Motorcycle.new
puts motorbike.range# 640.0
puts motorbike.tire_pressure(0)# 20
motorbike.inflate_tire(0, 35)
puts motorbike.tire_pressure(0)# 35

# problem 3:

boat = Motorboat.new(60, 5.5)
puts boat.propeller_count# 1
puts boat.hull_count# 1 
puts boat.range# 330.0

