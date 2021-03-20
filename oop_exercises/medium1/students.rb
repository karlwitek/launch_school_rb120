# Have 3 classes. The implementation details for the #initialize methods in Graduate and Undergraduate
# are missing. Fill in those details so that the following requirements are fulfilled:
# Graduate students have the option to use on-campus parking, while Undergraduates do not.
# Graduate and Undergraduate students both have a name and year associated with them.
# Alter no more than 5 lines of code:
# Use super? 


# class Student
#   def initialize(name, year)
#     @name = name
#     @year = year
#   end
# end

# class Graduate
#   def initialize(name, year, parking)
#   end
# end

# class Undergraduate
#   def initialize(name, year)
#   end
# end

# my solution:

class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super(name, year)
  end
end

# LS: same except for super in Undergraduate (no arguments)

class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super
  end
end

# Graduate and Undergraduate should be subclasses of Student. All 3 share two points of data,
# (name and year).  super calls a method further up the inheritance chain that has the same name
# as the enclosing method. By enclosing method, we mean the method where we are calling the keyword
# super. In this case, we want to call the Student#initialize method from within the Graduate#initialize
# and Undergraduate#initialize.  For Undergraduate, we call super without any arguments; this causes
# all arguements from the calling method to be passed to the superclass method that has the same name.
# (end up passing name and year to Student#initialize)
# Note: We could also delete the entire Undergraduate#initialize method; since it only calls
# Student#initialize with the same arguments and does nothing else. (we can omit it)
# Need to specify which arguments to pass from the Graduate class (super(name, year))
# Finally, set the parking parameter to an instance variable @parking from within Graduate#initialize.

# Further: There is one other form of the keyword super. We can call it as super(). This calls the
# superclasss method of the same name as the calling method, but here no arguments are passed to the
# superclass method at all. Can you think of a way to use super() in another Student related class?

class Student
  def initialize(name, year)
    @name = name
    @year = year
  end

  def first_day
    puts "Attend Orientation"
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super
  end
end

class Freshman < Student
  def first_day
    puts "Welcome!"
    super()
  end
end

joe = Freshman.new('Joe', 'freshman')
joe.first_day