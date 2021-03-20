# using the following code, multiply @age by 2 upon assignment, then multiply @age by 2
# again when @age is returned by the getter method.



class Person
  def age=(a)
    @age = a * 2
  end

  def age
    @age * 2
  end

end

person1 = Person.new
person1.age = 20
puts person1.age# 80

# LS: same code in solution. Performing calculations in accessor methods can be convenient if
# that's the only place that you need the calculation to be performed. (manually implement the
# getter and setter)

# another way: implement these calculations outside the accessor methods by creating a new
# method :

class Person
  def age=(age)
    @age = double(age)
  end

  def age
    double(@age)
  end

  private

  def double(value)
    value * 2
  end
end

# NOTE: under the private method. Restrict access to double from outside the class.
