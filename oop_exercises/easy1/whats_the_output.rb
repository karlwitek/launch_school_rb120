# what output does this code print? Fix this class so that there are no surprises waiting in store for the
# unsuspecting developer.



# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name#.to_s
#   end

#   def to_s
#     @name.upcase!
#     "My name is #{@name}."
#   end
# end

# name = 'Fluffy'
# fluffy = Pet.new(name)# my answers:               # LS 
# puts fluffy.name# MY NAME IS MY NAME IS FLUFFY    # Fluffy (uses getter method)
# puts fluffy# same as line 21                      # My name is FLUFFY. (only upcases. thought it would assign return value)
# puts fluffy.name# MY NAME IS MY NAME IS MY NAME IS FLUFFY # FLUFFY (getter method again, the object has been mutated)
# puts name # FLUFFY                                # FLUFFY (getter method , object mutated)

# commented out .to_s in initialize.  Made no difference..

# LS :

class  Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

# Fluffy
# My name is FLUFFY.
# Fluffy
# Fluffy

# LS :

# The original version of #to_s uses String#upcase! which mutates its arguments in place.  This causes
# @name to be modified, which in turn causes name to be modified: this is because @name and name reference
# the same object in memory.

# The to_s inside the initialize method: we need that for the challenge under Further Exploration.
# (me) The to_s in the initialize method is the original to_s , NOT the instance method version...
# BECAUSE the to to_s in initialize is inside of a class method (Pet#initialize)

# Further: what would happen in this case?

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name# using getter method
puts fluffy# calling instance method to_s
puts fluffy.name # using getter method again, no change in name, because there is not another object created.
puts name # 43 this puts is called on the name variable in main scope, incremented by one.

# this code 'works' because of that mysterious to_s call in Pet#initialize. However, that doesn't explain why
# this code produces the result it does. Can you?

# 42
# My name is 42.
# 42
# 43


# Student answer:

# The to_s method call within the initialize method assigns the @name instance variable to the return
# value of the argument name converted to a string. This allows the new string object '42' to have the
# upcase method called on it without throwing an error. Within the object, and for all methods called
# on the object, the name is the string object '42'. However the string object referred to by the name
# variable still exists outside of the fluffy object and thus can be manipulated externally as well.
# Outside of the object, the value referred to by name has been incremented to 43. In order to assign
# the new value to the object, 1) a setter method would need to be added to our class, and 2) the setter
# method would need to be called on the object, assigning the new variable value to it, like so:
