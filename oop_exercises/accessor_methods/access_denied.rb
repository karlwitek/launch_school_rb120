# modify the code so that the value of @phone_number can't be modified outside the class.


class Person
  attr_reader :phone_number

  def initialize(number)
    @phone_number = number
  end
end

person1 = Person.new(1234567899)
puts person1.phone_number

person1.phone_number = 9987654321
puts person1.phone_number

# We're ensuring that #phone_number can only be modified from within the class.
# use attr_reader instead of attr_accessor.  The phone number is provided when
# we instantiate the class.

