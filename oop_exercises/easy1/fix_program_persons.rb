# complete this program so that it produces the expected output:
# expected output:
# John Doe
# Jane Smith


class Person
  #attr_writer :first_name, :last_name

  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  def first_name= (value)
    @first_name = value.capitalize
  end

  def last_name= (value)
    @last_name = value.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
end

person = Person.new('john', 'doe')
puts person# John Doe # good.. 

person.first_name = 'jane'
person.last_name = 'smith'
puts person# jane smith  # not part of the expected output.
# Jane Smith  (After adding manual getter and setter methods that capitalize the argument and assign it to the
# instance variable)  Expected output did not include Jane Smith.  Not clear directions.

# attr_writer doesn't do anything but assign a value directly to an instance variable.  We want the name to be
# capitalized instead (and we should not expect the caller to do it for us). So we remove the attr_writer call,
# and add the setter methods(manual versions)


