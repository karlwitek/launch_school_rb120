# allow Truck to accept a second argument upon instantiation. Name the parameter bed_type and
# implement the modification so that Car continues to only accept one arguement.


class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle

  attr_reader :bed_type

  def initialize(year, bed_type)
    super(year)
    @bed_type = bed_type
  end
end

class Car < Vehicle
end

truck1 = Truck.new(1994, 'Short')
puts truck1.year
puts truck1.bed_type
# 1994
# Short

# makes sense for only Truck to accept a bed_type argument. However, we still want to
# keep the @year instance variable in Vehicle.  Use #super while passing it one argument
# year instead of all of them.
# In solution: we added #initialize to Truck instead of modifying #initialize in Vehicle
# because we didn't want Car to accept the bed_type parameter
