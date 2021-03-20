class MinilangError < StandardError; end

class Minilang
  attr_accessor :register, :stack

  CMDS = ['push', 'add', 'sub', 'mult', 'div', 'mod', 'pop', 'print']

  def initialize(string)
    @register = 0
    @stack = []
    @commands = string.split.map { |str| str.downcase }
  end

  def convert_array_of_cmds
    converted_array = @commands.map do |element|
      if element.to_i.to_s == element
        element.to_i
      else 
        element
      end
    end
    converted_array 
  end

  def check_cmd(cmd)
    raise MinilangError, "Invalid token: #{cmd.upcase} " unless CMDS.include?(cmd)
  end

  def check_stack
    raise MinilangError, 'Empty Stack!' if stack.empty?
  end

  def eval
    arr = convert_array_of_cmds
    arr.each do |cmd|
      if cmd.is_a? Integer
        @register = cmd
      elsif CMDS.include? cmd
        send cmd
      else 
        raise MinilangError, "Invalid Token #{cmd.upcase}"
      end
    end
    rescue MinilangError => e 
      puts e.message
  end

  def push
    stack << register
  end

  def add
    self.register += pop
  end

  def sub
    self.register -= pop
  end

  def mult
    self.register *= pop
  end

  def div
    self.register /= pop
  end

  def mod
    self.register = register.remainder(pop)# see LS
  end

  def print
    puts register
  end

  def pop
    check_stack
    self.register = stack.pop
  end
end


# SEE LS SOLUTION: 
# raise error in #pop. Used same #pop in other methods.  


Minilang.new('5 PUSH 3 MULT PRINT').eval# 15

# Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval# 5, 3, 8

# Minilang.new('5 PUSH 10 PRINT POP PRINT').eval# 10, 5

# Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval# 6

# Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval# 12

# Minilang.new('-3 PUSH 5 SUB PRINT').eval# 8

# Minilang.new('-3 PUSH 5 XSUB PRINT').eval# Invalid token: XSUB

# Minilang.new('6 PUSH').eval# nothing printed, no PRINT cmd.

# Minilang.new('5 PUSH POP POP PRINT').eval# Empty Stack!

Minilang.new('4 PUSH 4 ADDX 4 PRINT').eval

# 15
# Invalid Token ADDX
