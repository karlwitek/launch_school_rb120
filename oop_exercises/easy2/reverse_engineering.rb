# write a class that will display:

# ABC
# xyz

# when the following code is run:

# my_data = Transform.new('abc')
# puts my_data.uppercase
# puts Transform.lowercase('XYZ')

# class named Transform
# need attr_reader :my_data
# need a class method (self?) 
# can I call #uppercase on my_data getter method? (#lowercase?)

class Transform
  attr_reader :string

  def initialize(string)
    @string = string
  end

  def uppercase
    @string.upcase
  end

  def self.lowercase(str)
    str.downcase
  end
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

# ABC
# xyz
# LS :

class Transform
  def initialize(data)
    @data = data
  end

  def uppercase
    @data.upcase
  end

  def self.lowercase(str)
    str.downcase
  end
end

# The first line of code creates an object from the Transform class, using a single 
# argument whose value is 'abc'. We call the instance method, uppercase, using the 
# my_data object as the caller. This returns the value we were passes during initialization
# in uppercase, which we then print.

# We call the class method lowercase, passing it a value of XYZ. lowercase converts its
# argument to lowercase and returns the result, which we then print.

# The solution simply implements the necessary class and methods so the test code runs and
# produces the desired result.

# Obviously, we need a Transform class, since we are calling new with an argument, we also
# need an initialize method that takes that argument and stashes it away in an instance 
# variable.  We also define uppercase to simply return the value of that instance variable in
# uppercase.

# Also need the class method lowercase.  Must prefix it with self.. Unlike uppercase, lowercase
# must obtain the string to convert from some source other than an instance variable; class
# methods do not have access to instance variables.  Our test code uses an argument, so our
# method is implemented as one that takes an argument.  The method returns the value of the
# argument after converting it to lowercase.

# A class method is also called a 'singleton method'(the term is used in other contexts as well).
# Learn more later, may encounter this term.


