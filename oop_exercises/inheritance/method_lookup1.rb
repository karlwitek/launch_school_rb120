# determine the lookup path used when invoking cat1.color.  Only list the classes that were checked by
# Ruby when searching for #color method.


class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new('Black')
cat1.color

# my answer:  Cat, Animal
# correct: ruby searches for the method's class. If not found, then inspects the class's superclass. repeat
# use #ancestors to return an array containing the names of the classes in the lookup path based on the order
# in which they are checked.

