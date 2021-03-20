# modify pet_shelter_code2.rb so that the Shelter class stores
# the owners and the pets that the owner owns in a hash.

class Pet
  attr_reader :name, :animal

  def initialize(animal, name)
    @animal = animal
    @name = name
  end

  def to_s
    "a #{animal} named #{name}"
  end
end

class Owner
  attr_reader :name

  def initialize(name)
    @name = name
    @arr_of_pets = []
  end

  def add_pet(pet)
    @arr_of_pets << pet
  end

  def number_of_pets
    @arr_of_pets.size
  end
end

class Shelter
  attr_reader :owner_hash

  def initialize
    @owner_hash = {}
  end

  def adopt(owner, pet)
    if owner_hash.has_key?(owner)
      owner_hash[owner] << pet
    else
      owner_hash[owner] = [pet]
    end
    owner.add_pet(pet)
  end

  def print_adoptions
    owner_hash.each do |owner, pets|
      puts "#{owner.name} has adopted the following pets:"
      puts pets
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

