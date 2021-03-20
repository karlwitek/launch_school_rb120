# Modify this so both flip_switch and the setter method switch= are private methods:

# class Machine
#   attr_writer :switch

#   def start
#     self.flip_switch(:on)
#   end

#   def stop
#     self.flip_switch(:off)
#   end

#   def flip_switch(desired_state)
#     self.switch = desired_state
#   end
# end

# # solution:

# class Machine

#   def start
#     # self.flip_switch(:on)
#     flip_switch(:on)# commented out line is okay in Ruby 2.7 or higher
#   end

#   def stop
#     # self.flip_switch(:off)
#     flip_switch(:off)# same 2.7
#   end

#   private

#   attr_writer :switch

#   def flip_switch(desired_state)
#     self.switch = desired_state
#   end
# end

# Make flip_switch and attr_writer :switch privae . (only can be called from within the Machine class)
# Need to add a call to the Module#private in the class body prior to the definition of flip_switch.
# Also need to remove the self. callers from the two calls to flip_switch.
# (the caller is not necessary but is accepted when flip_switch is public, but it is prohibited when
# flip_switch is private)
# Made the setter for switch private. Easy to move the attr_writer call for switch into the private
# section of the class definition. Difficult part is the call to the setter method: unlike all other
# privated method calls, you must specify the caller when calling a setter method. If you try to remove
# the caller, ruby will create a local variable named switch. Now that we have our attr_writer and the
# flip_switch as private methods, the only way to set the instance variable @switch is through the 
# start and stop methods.

# Further: Add a private getter for @switch to the Machine class, and add a method to Machine that 
# shows how to use that getter.

class Machine

  def start
    # self.flip_switch(:on)
    flip_switch(:on)# commented out line is okay in Ruby 2.7 or higher
  end

  def stop
    # self.flip_switch(:off)
    flip_switch(:off)# same 2.7
  end

  def show_state# my solution
    @switch
  end

  private

  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

r2d2 = Machine.new
r2d2.start
puts r2d2.show_state
r2d2.stop
puts r2d2.show_state

# student solutions:(within class)


# def state
#   case switch
#     when :on then   "the switch is on."
#     when :off then  "the switch is off."
#   end
# end



# def status
#   puts "The Machine is #{@switch.to_s}"
# end