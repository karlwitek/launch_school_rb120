# modify to accept a string containing a first and a last name. The name should be split into
# two instance variables in the setter method, then joined in the getter method to form a full
# name.


class Person
  def name=(str)
    @first_name = str.split[0]
    @last_name = str.split[1]
  end

  def name
    @first_name + ' ' + @last_name
  end

end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name# John Doe

#

# LS:

class Person
  def name=(name)
    @first_name, @last_name = name.split(' ')
  end

  def name
    "#{@first_name} #{@last_name}"
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name

