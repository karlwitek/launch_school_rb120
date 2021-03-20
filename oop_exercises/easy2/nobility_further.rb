# Further (nobility.rb)
# 1.
# This exercise can be solved in a similar manner by using inheritance; a Noble is a Person,
# and a Cheetah is a Cat, and both Persons and Cats are Animals. What changes would you need
# to make to this program to establish these relationships and eliminate the two duplicated
# #to_s methods?

#2.
# Is to_s the best way to provide the name and title functionality we needed for this exercise?
# Might it be better to create either a different name method (or say a new full_name method)
# that automatically accesses @title and @name? There are tradeoffs with each choice -- they
# are worth considering.

#2. 

module Walkable
  def walk
    "#{name} #{gait} forward"
  end
end

class Person
  attr_reader :name

  include Walkable

  def initialize(name)
    @name = name
  end

  # def to_s
  #   name
  # end

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

  # def to_s
  #   name
  # end

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

  # def to_s
  #   name
  # end

  private

  def gait
    "runs"
  end
end

class Noble
  attr_reader :title

  include Walkable

  def initialize(name, title)
    @title = title
    @name = name
  end

  # def to_s
  #   "#{title} #{name}"
  # end

  def name
    "#{title} #{@name}"
  end

  private

  def gait
    "struts"
  end
end

c = Cat.new('Kitty')
p c.walk

b = Noble.new("Byron", "Lord")
p b.walk

# "Kitty saunters forward"
# "Lord Byron struts forward"
# Commented out all the #to_s methods.  created a 'manual' name method in Noble that includes
# the title and the name.  (works..)

# also change #{self} to #{name} in #walk.
