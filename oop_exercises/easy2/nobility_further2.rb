
# Further (nobility.rb)
# 1.
# This exercise can be solved in a similar manner by using inheritance; a Noble is a Person,
# and a Cheetah is a Cat, and both Persons and Cats are Animals. What changes would you need
# to make to this program to establish these relationships and eliminate the two duplicated
# #to_s methods?

# set up inheritance as stated.  
# use super in Noble to initialize 'title'
# change Walkable#walk back to #{self} instead of #{name} (using #to_s again)
# Reduce duplicated methods through inheritance

module Walkable
  def walk
    "#{self} #{gait} forward"
  end
end

class Animal
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end
end

class Person < Animal

  private

  def gait
    "strolls"
  end
end

class Noble < Person
  attr_reader :title

  def initialize(name, title)
    super(name)
    @title = title
  end

  def to_s
    title + ' ' + name
    #"#{title} #{name}"
  end

  private

  def gait
    "struts"
  end
end

class Cat < Animal

  private

  def gait
    "saunters"
  end
end

class Cheetah < Cat

  private

  def gait
    "runs"
  end
end


dude = Person.new('Dude')
p dude.walk
kitty = Cat.new('Kitty')
p kitty.walk
cheeto = Cheetah.new('Cheeto')
p cheeto.walk
king = Noble.new('Arthur', 'King')
p king.walk

# "Dude strolls forward"
# "Kitty saunters forward"
# "Cheeto runs forward"
# "King Arthur struts forward"


# module Walkable
#   def walk
#     "#{self} #{gait} forward"
#   end
# end

# This works because #{self} is the same as #{self.to_s}. (is disguised)
# #{} (interpolation) calls #to_s automatically.

# The #to_s is called on self. The #to_s of the object is called. The object is 
# represented by self. Another way: the object that calls #walk calls the #to_s
# method from its class. The #to_s method of the cat object returns name.
# The #to_s of the Noble object returns title and name.

# def to_s
#   title + ' ' + name
#   #"#{title} #{name}"
# end
# line 112 works also. line 113 commented out..(both work)

