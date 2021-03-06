# fix the following code so it works properly:

# should print 5678



class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  # def increment_mileage(miles)
  #   total = mileage + miles
  #   @mileage = total
  # end
  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total
  end
  
  def print_mileage
    puts mileage
  end
end

car = Car.new
car.mileage = 5000
car.increment_mileage(678)
car.print_mileage  # should print 5678
# 5678  Changed mileage + miles to @mileage + miles and mileage = total to @mileage = total
# can't increment value or assign value with getter method. (only for accessing)??
# Changed again: left mileage + miles as is , only changed @mileage = total
# (assigning new value to the instance variable @mileage)
# BETTER: USE THE SETTER METHOD!

# LS :

# solution 1: 
# def increment_mileage(miles)
#   total = mileage + miles
#   self.mileage = total
# end

# solution 2: same as my solution
# The problem with this code is that we are attempting to use a setter method for the @mileage instance
# variable like this:  mileage = total
# All this manages to do is create a local variable named mileage. When we run the code, the output is 
# 5000, not the expected 5678. To access the setter method, we need to provide an explicit caller:
# self.mileage = total
# or refer to the instance variable directly:  @mileage = total
# Solution 2 bypasses the setter method entirely, which may not be what you want.  Generally safer to use an
# explicit self. caller when you have a setter method unless you have a good reason to use the instance 
# variable directly. If available, calling the setter method is safer since using the instance variable 
# bypasses any checks or operations performed by the setter. Example:

# def mileage=(miles)
#   @mileage = miles.to_i
# end

# When you use the setter method elsewhere in your class, you're guaranteed that it will apply #to_i
# to the value. If you don't use the setter, you may set the mileage to a string value.

