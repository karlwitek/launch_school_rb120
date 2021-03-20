# we have a Walkable module. Some of the users are nobility, and the regular way of walking
# simply isn't good enough. Nobility need to strut.

# We need a new class Noble, that shows the title and name when walk is called:
# We must have access to both name and title because they are needed for other purposes that
# we aren't showing here.

# byron.name
# => "Byron"
# byron.title
# => "Lord"


# byron = Noble.new("Byron", "Lord")
# p byron.walk
# # => "Lord Byron struts forward"

module Walkable
  def walk
    puts "#{name} #{gait} forward"
  end
end

class Person
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

class Noble
  attr_reader :name, :title

  def initialize(name, title)
    @name = name
    @title = title
  end

  def walk
    puts "#{title} #{name} struts forward"
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
byron = Noble.new("Byron", "Lord")
byron.walk

# Mike strolls forward
# Kitty saunters forward
# Flash runs forward
# Now start this exercise:
# created Noble class with its own walk method.  works , but not the LS solution:
# LS:

module Walkable
  def walk
    "#{self} #{gait} forward"
  end
end

class Person
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  def to_s
    name
  end

  private

  def gait
    "runs"
  end
end

class Noble
  attr_reader :name, :title

  include Walkable

  def initialize(name, title)
    @title = title
    @name = name
  end

  def to_s
    "#{title} #{name}"
  end

  private

  def gait
    "struts"
  end
end

# Provide a method that returns the name and title for Nobles, and just the name for regular Persons, Cats, and Cheetahs.
# To do this, define an appropriate #to_s method for all 4 classes and then change Walkable#walk so it calls #to_s on
# the object. We define #to_s in all 4 classes, (returning the title and name in the Noble class). Finally, we tell 
# Walkable#walk to use #to_s to obtain the person's name(or name and title).
# In Walkable#walk, to_s is called automatically because of interpolation (#{}). So, #{self} in the string is actually
# #{self.to_s} in disguise. In the case of a Cat object, this calls Cat#to_s , but in the case of a Noble, it calls
# Noble#to_s.

