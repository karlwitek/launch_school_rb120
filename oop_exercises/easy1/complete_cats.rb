# consider the following program: Update it so you get the output:

# My cat Pudding is 7 years old and has black and white fur.
# My cat Butterscotch is 10 years old and has tan and white fur.
# write initialize for Cat, call super with other 2 arguments(name, age)
# write to_s method in Cat to display properly
# to_s in Pet??  NO? 


class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  attr_reader :name, :age, :color

  def initialize(name, age, color)
    super(name, age)
    @color = color
  end

  def to_s
    "My Cat #{name} is #{age} years old and has #{color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

# My Cat Pudding is 7 years old and has black and white fur.
# My Cat Butterscotch is 10 years old and has tan and white fur.
# good. LS :

# Since Cat#new requires arguments that differ from Pets#new, we must define an initialize method for Cat,
# and that method calls super with the correct arguments.
# Further: alternative approach would be to modify Pet class to accept a color parameter. If we did this,
# we wouldn't need to supply an initialize method for Cat.
# why can we omit initialize method? Is it a good idea to modify Pet in this way? why , why not?
# How might you deal with some of the problems, if any, that might arise from modifying Pet?

# Can omit initialize because Cat would inherit it from Pet.
# Not necessarily bad idea, but not all pets have fur. So would need additional/different to_s methods
# in Pet.  Probably better to keep color in subclasses so the to_s methods would be appropriate.

# student explanation: 

# The basic idea when coming up with an inheritance hierarchy is to generalize common state and
# behaviors into superclasses, and specialize into subclasses any state and behavior that is specific
# to only a subset of members of a class.

