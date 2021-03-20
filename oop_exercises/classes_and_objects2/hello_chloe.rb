# Add an instance method named #rename that renames kitty when invoked

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename(new_name)
    self.name = new_name# LS
    #@name = new_name
    #name = new_name  This doesn't work , using a setter method, need self.
  end

end

kitty = Cat.new('Sophie')
puts kitty.name
kitty.rename('Chloe')
puts kitty.name
# When invoking setter methods, they must be denoted with self. We're required to use self
# so that ruby knows the difference between initializing a local variable and invoking a 
# setter method.

