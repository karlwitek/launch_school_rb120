require 'set'

class MinilangError < StandardError; end
class BadTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  ACTIONS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  def initialize(program)
    @program = program
  end

  def eval(degrees_c: nil)
    @stack = []
    @register = 0
    formatted_program = format(@program, degrees_c: degrees_c)
    @program = formatted_program
    @program.split.each { |token| eval_token(token) }
  rescue MinilangError => error
    puts error.message
  end

  def eval_to_convert_miles(miles_per_hour: nil)
    @stack = []
    @register = 0
    formatted_program = format(@program, miles_per_hour: miles_per_hour)
    @program = formatted_program
    @program.split.each { |token| eval_token(token) }
  rescue MinilangError => error
    puts error.message
  end

  def eval_rectangle(width: 0, length: 0)
    @stack = []
    @register = 0
    formatted_program = format(@program, width: width, length: length)
    @program = formatted_program
    @program.split.each { |token| eval_token(token) }
  rescue MinilangError => error
    puts error.message
  end

  private

  def eval_token(token)
    if ACTIONS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      @register = token.to_i
    else
      raise BadTokenError, "Invalid token: #{token}"
    end
  end

  def push
    @stack.push(@register)
  end

  def pop
    raise EmptyStackError, "Empty stack!" if @stack.empty?
    @register = @stack.pop
  end

  def add
    @register += pop
  end

  def div 
    @register /= pop
  end

  def mod 
    @register %= pop
  end

  def mult 
    @register *= pop
  end

  def sub 
    @register -= pop
  end

  def print 
    puts @register
  end
end

# Minilang.new('2 PUSH ADD 5 PRINT').eval

CENTIGRADE_TO_FAHRENHEIT = 
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'

# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval# 212

# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 0)).eval

# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -40)).eval

# Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -100)).eval

# Now alter code: make #eval accept the argument to accept degrees_c:

minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100)# 212
minilang.eval# 212

minilang2 = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang2.eval(degrees_c: 50)# 122

# wrote #eval_to_convert_miles
# 3 miles == 5 km
MILES_TO_KM = '3 PUSH 5 PUSH %<miles_per_hour>d MULT DIV PRINT'
minilang3 = Minilang.new(MILES_TO_KM)
minilang3.eval_to_convert_miles(miles_per_hour: 10)

# wrote #eval_rectangle 
MEASUREMENTS = '%<width>d PUSH %<length>d MULT PRINT'
minilang4 = Minilang.new(MEASUREMENTS)
minilang4.eval_rectangle(width:5, length: 10)# 50

# What should be the default values of degrees_c, miles_per_hour, etc..?

