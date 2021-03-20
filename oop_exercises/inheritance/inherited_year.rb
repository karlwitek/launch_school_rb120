# create 2 classes. Truck and Car that inherit from Vehicle


class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
end

class Car < Vehicle
end


truck1 = Truck.new(1994)
puts truck1.year

car1 = Car.new(2006)
puts car1.year
# 1994
# 2006

# The superclass implements the common behaviors while the inheriting 
# classes invoke them.

