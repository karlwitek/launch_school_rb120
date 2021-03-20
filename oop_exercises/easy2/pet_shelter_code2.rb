class Pet
  attr_reader :name, :type

  def initialize(type, name)
    @type = type
    @name = name
  end

  def to_s
    "a #{type} named #{name}"
  end
end

class Owner
  attr_reader :name, :total_pets

  def initialize(name)
    @name = name
    @total_pets = []
  end

  def add_pet(pet)
    total_pets << pet
  end

  def number_of_pets
    total_pets.size
  end

  def print_pets
    puts total_pets
  end
end

class Shelter

    def initialize
     @owners = []
    end

    def adopt(owner, pet)
      owner.add_pet(pet)
      @owners << owner unless @owners.include?(owner)
    end

    def print_adoptions
      @owners.each do |owner|
        puts "#{owner.name} has adopted the following pets:"
        owner.print_pets
        puts
      end
    end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

# 1st change: use getter method for total_pets in Owner class.
# 2nd change: use an array to store all the owners instead of a hash. Use owner.name in
# print_adoptions method instead of name... good.

# Further: 
# Add your own name and pets to this project.
# Suppose the shelter has a number of not-yet adopted pets, and wants to 
# manage them through this same system.  Thus, you should be able to add the 
# following output to the existing output.
# Can you make these updates to your solution? Did you need to change your 
# class system at all? Were you able to make all of your changes without modifying
# the existing interface?

# not going to add a name attribute for the Shelter class. (for now)
# add print_pets to Shelter class that uses to_s in Pet class.
# add an instance method to Shelter class that lets the user add pets to available list
# add an instance method to Shelter class that returns the number of available pets

# The Animal Shelter has the following unadopted pets:
# a dog named Asta
# a dog named Laddie
# a cat named Fluffy
# a cat named Kat
# a cat named Ben
# a parakeet named Chatterbox
# a parakeet named Bluebell
#    ...

# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.
# The Animal shelter has 7 unadopted pets.

