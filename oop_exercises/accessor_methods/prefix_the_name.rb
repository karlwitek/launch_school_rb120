# add the appropriate accessor methods so that @name is returned with the added prefix 'Mr.'


class Person
  attr_reader :name

  def name=(n)
    @name = "Mr. " + n
  end
end

person1 = Person.new
person1.name = 'James'
puts person1.name# Mr. James

# LS:

class Person
  attr_writer :name

  def name
    "Mr. #{@name}"
  end
end

person1 = Person.new
person1.name = 'James'
puts person1.name

# My solution was backwards.

# In this example, if we prefixed @name upon assignment, the value would be modified, which
# may not be what we want. The goal is to return the value of @name, but with a prefix.

# We need to manually implement the getter method.  (need extra functionality).
# Therefore, to return the prefixed @name, we need to add the desired prefix, and add
# @name through string interpolation.
