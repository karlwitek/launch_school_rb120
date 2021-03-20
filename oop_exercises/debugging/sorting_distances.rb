class Length
  attr_reader :value, :unit

  def initialize(value, unit)
    @value = value
    @unit = unit
  end

  def as_kilometers
    convert_to(:km, { km: 1, mi: 0.6213711, nmi: 0.539957 })
  end

  def as_miles
    convert_to(:mi, { km: 1.609344, mi: 1, nmi: 0.8689762419 })
  end

  def as_nautical_miles
    convert_to(:nmi, { km: 1.8519993, mi: 1.15078, nmi: 1 })
  end

  def <=>(other)
    case unit
    when :km  then value <=> other.as_kilometers.value
    when :mi  then value <=> other.as_miles.value
    when :nmi then value <=> other.as_nautical_miles.value
    end
  end

  def ==(other)
    case unit
    when :km  then value == other.as_kilometers.value
    when :mi  then value == other.as_miles.value
    when :nmi then value == other.as_nautical_miles.value
    end
  end

  def <(other)
    case unit
    when :km  then value < other.as_kilometers.value
    when :mi  then value < other.as_miles.value
    when :nmi then value < other.as_nautical_miles.value
    end
  end

  def <=(other)
    self < other || self == other
  end

  def >(other)
    !(self <= other)
  end

  def >=(other)
    self > other || self == other
  end

  def to_s
    "#{value} #{unit}"
  end

  private

  def convert_to(target_unit, conversion_factors)
    Length.new((value / conversion_factors[unit]).round(4), target_unit)
  end
end

# Example

puts [Length.new(1, :mi), Length.new(1, :nmi), Length.new(1, :km)].sort
# => comparison of Length with Length failed (ArgumentError)
# expected output:
# 1 km
# 1 mi
# 1 nmi

# When attempting to sort an array of various lengths, we are surprised to see that an
# ArgumentError is raised. Make changes so the various lengths can be properly sorted and line 62
# produces the expected output.

# puts [Length.new(1, :mi).value, Length.new(1, :nmi).value, Length.new(1, :km).value].sort
# my solution (line 73). added .value so that #sort can compare a number instead of an object.
# Not correct.  The problem is that we need a #<=> method for the Length class.

# LS: We invoke Array#sort. It sorts the elements based on comparisons done by the #<=> method.
# Therefore, the objects in the collection we are sorting must have access to a <=> method.
# Since our Length class does not implement a <=> method, we get an error saying that the 
# 'comparison of Length with Length failed'.  We need to implement a Length#<=> method.

# def <=>(other)
#   case unit
#   when :km  then value <=> other.as_kilometers.value
#   when :mi  then value <=> other.as_miles.value
#   when :nmi then value <=> other.as_nautical_miles.value
#   end
# end

# We could remove the ==, <, >, <=, >= methods if we include the Comparable module as it implements
# all of the comparison methods based on <=> .

# FE:
# Length.new(10, :km).as_nautical_miles.as_kilometers == Length.new(10, :km) # => false
# Working with floating point numbers involves imprecision. The above is false because converting
# 10 km to miles and back again => 10.0001
# This is why tests of methods that involve floating point numbers often don't check equality
# but equality within a certain delta. example: (assuming we also implement arithmetic methods 
# like Length#-):

# (Length.new(10, :km).as_nautical_miles.as_kilometers - Length.new(10, :km)).abs < 0.001 # => true
