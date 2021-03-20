# A fixed-length array is an array that always has a fixed number of elements. Write a class that
# implements a fixed-length array, and provides the necessary methods to support the following code.
# Should output 'true' 16 times . ( There are 16 calls to puts )

# fixed_array = FixedArray.new(5)
# puts fixed_array[3] == nil
# puts fixed_array.to_a == [nil] * 5

# fixed_array[3] = 'a'
# puts fixed_array[3] == 'a'
# puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

# fixed_array[1] = 'b'
# puts fixed_array[1] == 'b'
# puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

# fixed_array[1] = 'c'
# puts fixed_array[1] == 'c'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

# fixed_array[4] = 'd'
# puts fixed_array[4] == 'd'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
# puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

# puts fixed_array[-1] == 'd'
# puts fixed_array[-4] == 'c'

# begin
#   fixed_array[6]
#   puts false
# rescue IndexError
#   puts true
# end

# begin
#   fixed_array[-7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

# begin
#   fixed_array[7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

# my attempt:

# class FixedArray
#   attr_accessor :array

#   def initialize(length)
#     @array = [nil] * length
#   end

#   # def to_s
#   #   'array'
#   # end

#   def to_a
#     array.to_s
#   end

#   def [](idx)
#     array[idx]
#   end

#   def []=(idx, val)
#     array[idx] = val
#   end
# end

# fixed_array = FixedArray.new(5)
# # puts fixed_array
# # puts fixed_array.to_a
# # fixed_array[2] = 2
# # p fixed_array[2]
# puts fixed_array.to_a

# puts fixed_array[3] == nil
# puts fixed_array.to_a == [nil] * 5

# fixed_array[3] = 'a'
# puts fixed_array[3] == 'a'
# puts fixed_array.to_a == [nil, nil, nil, 'a', nil]
# puts fixed_array.to_a

# LS -->

class FixedArray
  def initialize(max_size)
    @array = Array.new(max_size)
  end

  def [](index)
    @array.fetch(index)
  end

  def []=(index, value)
    self[index] # raise error if index is invalid
    @array[index] = value
  end

  def to_a
    @array.clone
  end

  def to_s
    to_a.to_s
  end
end


fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end

# The 'is-a' relationship generally implies the need of inheritance ( from the standard Array class)
# However, inheriting from Array means you need to verify that all of the standard Array methods
# will work properly with the fixed-length requirement. ( could be a lot of code). Furthermore,
# it is generally bad form to inherit from standard classes, instead, you should use a
# collaborator object.
# We take the collaborative approach with our solution, and the collaborator is regular ruby Array.
# Only those methods we implement will be available to users of the FixedArray class, so we don't
# need to worry about all of the standard Array methods.
# The initialize method takes a single argument that specifies the desired size of the FixedArray,
# and uses this to initialize @array to max_size elements, all with an initial value of nil.

# We need the [] operator to work when getting element values, and []= operator when setting
# element values. Both operators should raise an IndexError exception if the index is out of range.
# To implement the [] operator, we need a #[] method. Our implementation uses Array#fetch to retrieve
# the indicated element, #fetch raises an IndexError exception if the index is out of range, so we
# don't have to do anything special.  Our []= method uses #[] to make sure an IndexError is raised
# if needed, but just reuses Array#[]= to assign the value of the indicated element.

# The example code shows that we want a #to_a method to convert a FixedArray object to a regular
# Array.  We return a copy of the underlying Array collaborator.  Note that we use #clone to copy
# the Array; the caller is requesting an Array version of our instance, and we don't want the caller
# doing something to that Array that will make our FixedArray inconsistent. 
# Finally, we can implement #to_s by calling Array#to_s on the return value of #to_a.
# Begin/rescue/end 'exception handler' in the test cases.
