# modify the code so it works. You are allowed to write one new method to do this.


class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def walk
    puts "#{name} #{gait} forward"
  end

  private

  def gait
    "strolls"
  end
end

class Cat < Person

  private

  def gait
    "saunters"
  end
end

class Cheetah < Person

  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"

# use inheritance to make all classes inherit from Person
# def walk in Person to puts the name, gait and the word 'forward'

# Mike strolls forward
# Kitty saunters forward
# Flash runs forward
# good!!

# LS :

# created a module 'Walkable'.  Then included it in each class.

# module Walkable
#   def walk
#     "#{name} #{gait} forward"
#   end
# end

# You can use the Walkable module as a mixin with any class that defines gait and name. You can also define a parent
# class and make other classes inherit from that class. (what I did)

# However, 'modules are more appropriate in a "has-a" relationship'.  A guideline is to decide if you want some
# additional functionality, or if you want to extend the abilities of the class.  In this case, it is pretty clear
# that we need the functionality of walking; we don't need to extend the abilities of class Person.
# (extending the abilities of a class coincides with an "is-a" relationship, not "has-a")

