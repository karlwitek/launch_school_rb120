# creat a class, Cat that prints a greeting when #greet is invoked.
# the greeting should include the name and the color (constant) of the cat.

class Cat
  COLOR = 'black'
  def initialize(name)
    @name = name
  end

  def greet
    puts "#{@name} is a #{COLOR} cat."
  end
end
kitty = Cat.new('Sophie')
kitty.greet# Sophie is a black cat.

# the constant can be used in all Cat instances.
# LS solution uses attr_reader :name and #{name} instead of #{@name}



