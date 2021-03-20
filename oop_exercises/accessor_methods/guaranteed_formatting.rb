# add the appropriate accessor methods so that @name is capitalized upon assignment.


class Person
  attr_reader :name

  def name=(n)
    @name = n.capitalize
  end

end

person1 = Person.new
person1.name = 'eLiZaBeTh'
puts person1.name# Elizabeth

# Sometimes it makes sense to format, validate the data immediately. In this exercise,
# we are asked to format while assigning it to the instance variable @name.
# Since we have to add extra functionality to the method, we have to manually write the 
# setter method.

# LS:

# def name=(name)
#   @name = name.capitalize
# end
