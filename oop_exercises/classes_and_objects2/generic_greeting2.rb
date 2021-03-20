# add two methods: ::generic_greeting and #personal_greeting

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.generic_greeting
    puts "Hello! I'm a #{self.name}."# self.name accesses class name here
  end

  def generic_greeting
    puts "Hello! My name is #{self.name}."# would work without self. works this way too. Ruby knows it is instance method.

  end
end

kitty = Cat.new('Sophie')
Cat.generic_greeting# Hello! I'm a Cat.
kitty.generic_greeting# Hello! My name is Sophie.

# class method are only associated with the class itself, not any instance of the class.  Within class
# methods, we're restricted from adding data specific to objects of the class, like adding a name to 
# an instance of Cat. Think of class methods as generic actions a class may perform
