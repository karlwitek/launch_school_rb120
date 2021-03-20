class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end

  def ==(other)
    [latitude, longitude] == [other.latitude, other.longitude]
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true
                                    # actual: false

# why does line 39 return false? 
# comparing two objects. @location is assigned an object. This #== is checking if the two objects are the same objects.
# we need to define our own #== method that compares an attribute (or both in this case). If we did this, then #== could
# compare the values of the object and NOT if they are the same object. (me) see line 26

# LS: Since our GeoLocation class does not implement ==, Ruby invokes the method from the BasicObject
# class. BasicObject#== returns true only if the two objects being compared are the same object, or in
# other words, if they have the same object id.  In order to compare the equality of instances of our
# custom class, which overrides BasicObject#== (thanks to Ruby's method lookup path) GeoLocation#==
# does exactly that: it compares two locations based on their latitude and longitude values.

# def ==(other)
#   latitude == other.latitude && longitude == other.longitude
# end

