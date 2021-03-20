# refactor these classes so they all use a common superclass, and inherit behavior as needed:


class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end


class Car < Vehicle

  def wheels
    4
  end
end

class Motorcycle < Vehicle

  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

# common behaviors #initialize, (Truck will still have #initialize to handle 'payload') + need super
# leave wheels method in each class
# put to_s method in Vehicle, remove from other classes

my_car = Car.new('Ford', 'Windstar')
my_bike = Motorcycle.new('Harley', 1500)
my_truck = Truck.new('Ford', 'F250', 1000)

puts my_car
puts my_bike
puts my_truck

# Ford Windstar
# Harley 1500
# Ford F250

puts my_truck.payload# 1000

puts my_car.wheels
puts my_bike.wheels
puts my_truck.wheels

# 4
# 2
# 6
# good. LS:

# same code :  Further: Would it make sense to define a wheels method in Vehicle even though all of the remaining
# classes would be overriding it? why, why not? If you think it does make sense, what method body would you write?

# Most vehicles have 4 wheels, so it may make sense to include it in Vehicles.  Override as necessary.

