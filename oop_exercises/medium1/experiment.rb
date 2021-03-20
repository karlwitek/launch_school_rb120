class Person
  #attr_reader :name

  def initialize(name)
    @name = name
  end

  def greeting
    puts "Hello #{self.name}"# works (optional) if attr_reader is not private
  end

  def change_name(new_name)
    self.name = new_name
    # @name = new_name // works!
  end

  private
  attr_reader :name
  attr_writer :name
end

tom = Person.new('Tom')
tom.greeting
tom.change_name('Joe')
tom.greeting

class Machine

  def start
    #self.flip_switch(:on) // okay in Ruby 2.7 or higher
    flip_switch(:on)
  end

  def stop
    #self.flip_switch(:off)  //  same 2.7
    flip_switch(:off)
  end

  def show_state# my solution
    puts switch
  end

  def change_state
    self.switch = :neither
  end

  private

  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

hal = Machine.new
hal.start
hal.show_state
hal.stop
hal.show_state
hal.change_state
hal.show_state