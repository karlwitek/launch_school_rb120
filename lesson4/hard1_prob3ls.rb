# Problem 3: Incorporate a new Motorboat class (1 hull, 1 propeller) and behaves similar to Catarmaran.
# Create a new class to present the common elements of motorboats and catamarans.  (Seacraft). We still
# want to include the Moveable module to get support for calculating the range.



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

class Seacraft
  include Moveable

  attr_reader :hull_count, :propeller_count

  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    self.fuel_efficiency = fuel_efficiency
    self.fuel_capacity = fuel_capacity
  end

  def range
    @fuel_capacity * @fuel_efficiency + 10
  end
end
# We can now implement a Motorboat based on the Seacraft definition.  We don't need to reference to Moveable
# since that is already included in the Seacraft super class.

class Motorboat < Seacraft
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

class Catamaran < Seacraft

  # def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
  #   super
  # end // The super method automatically passes along any arguments which the original method received
  #   because of this, we can remove the arguments being passed into super (above)
  # In fact, because super is the only statement in this initialize method and there's nothing to override it
  # we can remove it altogether
end


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

boat = Motorboat.new(40, 13.5)
puts boat.range# 540.0
puts boat.hull_count# 1 
puts boat.propeller_count# 1

my_cat = Catamaran.new(4, 2, 35, 12.5)
puts my_cat.range# 437.5
puts my_cat.hull_count# 2

bike = Motorcycle.new
puts bike.tire_pressure(1)# 20
bike.inflate_tire(1, 35)
puts bike.tire_pressure(1)# 35

# Problem 4: Make adjustment for how the range of vehicles is calculated.  For the seaborne vehicles, add
# an additional 10km of range even if the vehicle is out of fuel. Autos and Motorcycles will stay the same.

boat = Motorboat.new(80, 8.0)
puts boat.range# 650.0

bike = Motorcycle.new
puts bike.range# 640.0
# good. created own range method in Seacraft.
# LS: similar to my solution (override in Seacraft), but uses super to get the value first, then adds 10

# def range
#   super + 10
# end

