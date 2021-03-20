# add the appropriate accessor method to the following code:


class Person
  attr_accessor :name
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name# Jessica

# person1.name = 'Jessica'
# person1.name=('Jessica')
# these two method invocations are the same, Ruby's syntactical sugar allows the first one.
# To access an object's instance variables from outside the object, we need to invoke an 
# accessor method.  In example: after the instantiation of person1, we invoke a method named
# name=. see above.
# can manually implement #name= inside the class like so:
# def name=(value)
#   @name = value
# end
