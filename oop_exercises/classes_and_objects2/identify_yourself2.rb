# code so it prints I'm Sophie when it invokes puts kitty

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    #puts "I'm #{name}!"
    "I'm #{name}!"
  end

end

kitty = Cat.new('Sophie')
puts kitty
# I'm Sophie!
# #<Cat:0x0000000005164e78>
puts kitty# I'm Sophie!  Removed puts in the method. Just a return value
