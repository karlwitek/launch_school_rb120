# add an instance method named compare_secret that compares the value of @secret from
# person1 with the value of @secret from person2.


class Person
  attr_writer :secret

  def compare_secret(other_secret)
    secret == other_secret.secret
  end


  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)# false

# Protected methods are very similar to private methods.  The main difference between them
# is that protected methods allow access between class instances, while private methods don't.
# If a method is protected, it can't be invoked from outside the class.  This allows for
# controlled access, but wider access between class instances.
# solution: pass person2 as an argument into #compare_secret.
