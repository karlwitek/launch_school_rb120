# The following code is flawed.  It allows @name to be modified from outside the method via a 
# destructive method call fix. Fix the code so that it returns a copy of @name instead of a 
# reference to it.


class Person

  def initialize(name)
    @name = name
  end

  def name
    @name.dup
  end

end

person1 = Person.new('James')
person1.name.reverse!
puts person1.name# James

# LS:

class Person
  def initialize(name)
    @name = name
  end

  def name
    @name.clone
  end
end

person1 = Person.new('James')
person1.name.reverse!
puts person1.name

# getter methods typically return a reference to the instance variable. If you use this 
# reference to mutate the return value, you also mutate the instance variable.
# To prevent this, we can invoke #clone method on @name instead of a reference to it.
# This means that any modifications done to the return value won't affect the value of 
# @name. 

