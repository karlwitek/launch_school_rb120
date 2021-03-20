# change code so that creating a new Truck automatically invokes #start_engine.

class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
    start_engine
  end
end

class Truck < Vehicle
  def start_engine
    puts 'Ready to go!'
  end
end

truck1 = Truck.new(1994)
puts truck1.year

# Ready to go!
# 1994

# Not quite right:  LS :

class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  def initialize(year)
    super
    start_engine
  end

  def start_engine
    puts 'Ready to go!'
  end
end

truck1 = Truck.new(1994)
puts truck1.year

# The reason that Truck#start_engine executes instead of Vehicle#start_engine has to do with the order in 
# which Ruby looks through the inheritance hierarchy for a method. Here, the sequence looks like this:

# Truck
# Vehicle
# Object
# Kernel
# BasicObject

# Thus, ruby stops looking for the method as soon as it finds it.  Truck#start_engine overrides Vehicle#start_engine.
# If we want to override a method , but still have access to funcitonality from a superclass, use 'super'.

# When #super is invoked within a method, Ruby looks in the inheritance hierarchy for a method with the same name.
# solution: we use Vehicle#initialize, then we invoke #start_engine. Invoking #super without parentheses passes
# all arguments to Vehicle#initialize.

