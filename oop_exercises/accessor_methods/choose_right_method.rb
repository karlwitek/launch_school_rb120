# add the appropriate accessor methods to the following code:

class Person
  attr_reader :name
  attr_writer :name, :phone_number
end

person1 = Person.new
person1.name = 'Jessica'
person1.phone_number = '0123456789'
puts person1.name# Jessica

# LS:

class Person
  attr_accessor :name
  attr_writer :phone_number
end

# we want to be able to modify the value of @phone_number, but not retreive it. 
# In this class, we're choosing to keep the phone number a secret.