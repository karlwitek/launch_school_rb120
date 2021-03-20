# determine the lookup path used when invoking cat1.color.  Only list the classes and 
# modules that ruby will check when searching for the #color method.

class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color
# Cat, Animal

# Cat
# Animal
# Object
# Kernel
# BasicObject

# Needed all of the classes because the method doesn't exist.

# NOTE: Kernel is a module


