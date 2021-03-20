# create a module named Transportation that contains three classes:
# Vehicle, Truck, Car.  Truck and Car should both inherit from Vehicle

module Transportation
  class Vehicle ; end
  class Truck < Vehicle
  end
  class Car < Vehicle
  end
end

# Modules are good for namespacing.  Namespacing is where similar classes are grouped within
# a module.  Makes it easier to recognize the purpose of the contained classes.
# Grouping classes in a module can also help avoid collision with classes of the same name.

# can instantiate a class that's contained in a module by invoking the following:

#  Transportation::Truck.new

class MeMyselfAndI
  self

  def self.me
    self
  end

  def myself
    self
  end
end

i = MeMyselfAndI.new