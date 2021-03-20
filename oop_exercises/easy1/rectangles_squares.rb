# given the following class, write a class called square that inherits from Rectangle and is used like this:

# square = Square.new(5)
# puts "area of square = #{square.area}"


class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

# write class square, takes has one parameter. Inherits from Rectangle. Use super with two parameter of same value.?
# REMEMBER TO INHERIT '<'

class Square < Rectangle
  def initialize(length_of_side)
    super(length_of_side, length_of_side)
  end
end

square = Square.new(5)
puts "area of square = #{square.area}"# area of square = 25

# good. LS :

# Key thing is that we must call super in Square#initialize, and that Square inherits the area method
# from Rectangle


