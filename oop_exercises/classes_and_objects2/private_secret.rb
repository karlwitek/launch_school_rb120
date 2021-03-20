# add a method named share_secret that prints the value of @secret when invoked:

class Person
  attr_writer :secret

  def share_secret
    puts secret
  end

  private

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
person1.share_secret# Shh.. this is a secret!

# secret is a private getter method. Can invoke from within the class, but not
# from outside the class.
# Also (me) only on the instance object ??

