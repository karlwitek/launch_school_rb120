# add the appropriate accessor methods.  last_name getter shouldn't be visible outside
# the classs, while the first_name getter should be visible outside the class.

class Person
  attr_accessor :first_name
  attr_writer :last_name

  def first_equals_last?
    first_name == last_name
  end
  private

  attr_reader :last_name
end

person1 = Person.new
person1.first_name = 'Dave'
person1.last_name = 'Smith'
puts person1.first_equals_last?# false

# we place attr_reader after the call to private.  This means that only Person has access
# to this method. Public methods like first_equals_last? can be used to access @last_name
# through the private accessor method. However, last_name can't be invoked outside the class.

# example:

# class Person
#   attr_writer :last_name

#   private

#   attr_reader :last_name
# end

# person1 = Person.new
# person1.last_name = 'Smith'
# person1.last_name # => NoMethodError
