# Modify the following code so that Hello! I'm a cat! is printed
# when Cat.generic_greeting is invoked.

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting
# could also def Cat.generic_greeting , but self.generic_greeting is preferred.

kitty = Cat.new
# kitty.generic_greeting  / error (not an instance method)
