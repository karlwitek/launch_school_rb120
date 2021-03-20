# Modify the House class so that the above program will work.  You are permitted to define
# only one new method in House.

# output:
# Home 1 is cheaper
# Home 2 is more expensive



class House
  attr_reader :price
  include Comparable# add this line

  def initialize(price)
    @price = price
  end

  def <=>(other)# this method added
    price <=> other.price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

# Making objects comparable is quite easy; you don't have to create every possible comparison
# operator for the object.  Need to include Comparable mixin, and define one method: <=>.
# The <=> method should return 0 if the two objects are equal, 1 if the receiving object
# is greater than the other object, and -1 if the receiving object is less than the other
# object.  Often, comparing numbers or strings, which have a <=> operator defined.
# Rarely will have to write an involved <=> method.

# Further: Is the technique we employ here to make House objects comparable a good one?
# (Hint: is there is a natural way to compare Houses?) What problems might you run into?
# Can you think of any sort of classes where including Comparable is a good idea?

# student submission:

# You might run into a problem if the instance variable involved in the comparison
# hasn't been initialized yet, for instance a Person class that compares based on IQ,
# but one person hasn't taken an IQ test yet, so their @iq is currently set to nil.

# You might also run into problems if you ended up trying to compare different object
# types (ie: one house price is an int and the other is a string) or comparing objects
# that don't have a comparison operator (<=>) defined.
