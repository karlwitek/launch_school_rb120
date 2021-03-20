# what's wrong with the following code? What fix(es) would you make?
# to_s is calling a class method instead of an instance method...



class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander

# xyzxyzxyz
# removed self.expand(3)  (removed the self.) The error was 'private method 'expand'' called for #<Expander:...>
# I think the problem was that self.expand(3) is trying to call a class method instead of an instance method.
# (Actually, private methods can never be called with an explicit caller, even when that caller is self.) (LS)

# LS :
# The Expand#to_s method tries to call the private #expand method with the syntax self.expand(3). This fails though,
# since private methods can never be called with an explicit caller, even when that caller is self . Thus, #expand must
# be called as expand(3).

# AS of Ruby 2.7, it is now legal to call private methods with a literal self as the caller.



