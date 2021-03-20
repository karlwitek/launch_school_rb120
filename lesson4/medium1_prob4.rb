class Greeting
  def greet(string)
    puts string
  end
end

class Hello < Greeting
  def hi
    greet "Hello"
  end
end

class Goodbye < Greeting
  def bye
    greet "Goodbye"
  end
end

# hello = Hello.new
# hello.hi

# goodbye = Goodbye.new
# goodbye.bye

# Hello
# Goodbye

# LS: correct. used (). greet('Hello')

# 5. 

class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    if @filling_type == nil
      first_word = 'Plain'
    else
      first_word = @filling_type
    end
    if @glazing != nil
      second_word = "with #{@glazing}"
    else
      second_word = nil
    end
    "#{first_word} #{second_word}".strip
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
#  => "Plain"

puts donut2
#  => "Vanilla"

puts donut3
#  => "Plain with sugar"

puts donut4
#  => "Plain with chocolate sprinkles"

puts donut5
#  => "Custard with icing"

# Write additional code for KrispyKreme such that the puts statements will work as specified above:
# Plain
# Vanilla
# Plain with sugar
# Plain with chocolate sprinkles
# Custard with icing
# LS :  
# Need to define the to_s method for the class, and then have logic that can synthesize the name based on
# the combinations of filling and glazing.

# def to_s
#   filling_string = @filling_type ? @filling_type : 'Plain'
#   glazing_string = @glazing ? "with #{@glazing}" : ''
#   filling_string + glazing_string
# end
