# Add a method named #identify that returns its calling object

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def identify
    self
  end

end
kitty = Cat.new('Sophie')
p kitty.identify # #<Cat:0x000000000518d9e0 @name="Sophie">

puts kitty # #<Cat:0x000000000509b8e8>
puts kitty.identify # #<Cat:0x000000000509b8e8> (same , need p )
# p calls inspect which lets us see the instance variables and their values.

