# create a class, Person with an instance variable named @secret.  Use a setter
# method to add a value to @secret, then use a getter method to print @secret.

class Person
  attr_reader :secret
  attr_writer :secret

end



person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
puts person1.secret# Shh.. this is a secret!

# All of the instance methods used in the exercises so far have been public methods.
# Public methods can be accessed from both within the class nad outside the class.

# I used attr_reader and attr_writer.  LS uses attr_accessor. Could also use :

# class Person
#   def secret
#     @secret
#   end

#   def secret=(value)
#     @secret = value
#   end
# end
