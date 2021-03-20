# modify #start_engine in Truck by appending 'Drive fast, please!' to the return value of 
# start_engine in Vehicle. The 'fast' in value should be the value of 'speed'.


class Vehicle
  def start_engine(speed)
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
    super
    "Drive #{speed}, please!"
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')# Drive fast, please!


class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
    super() + " Drive #{speed}, please!"
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')

# #start_engine in Vehicle doesn't accept any arguments. If we passed speed as an argument, we would get an
# error.  To remedy this, we can invoke #super with empty parentheses, which means no arguments will be
# passed.

