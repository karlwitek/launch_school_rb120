class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def light_status# was def self.light_status (code is wrong. (LS))
    "I have a brightness level of #{brightness} and a color of #{color}"
  end

end

light = Light.new(20, 'white')
puts light.light_status
# puts Light.light_status