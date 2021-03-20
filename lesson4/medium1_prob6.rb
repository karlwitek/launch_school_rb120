class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# What is the difference in the way the code works?
# Top: uses @template (instance variable) to store the value of the string , and uses the getter method to display
# the value of the string in show_template.
# Bottom: uses the setter method by using self to store the value of the string into the instance variable template.
# Also uses the getter method to display the value stored in template. (optional syntax)

# LS: No difference in the result, only in the way each example accomplishes the task.  self isn't needed in the 
# second example. show_template invokes the getter method, which doesn't require self, unlike the setter method.
# The general rule (from Ruby style guide) is to 'Avoid self where not required'.

# 7.  change def self.light_status to def self.status to make it more clear and less repetitive.
# LS:  correct.  When invoking, would call: Light.light_status (class method). Having 'light' appear
# twice is redundant.  Rename to self.status. Reads much better.



