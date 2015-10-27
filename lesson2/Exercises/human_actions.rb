module Walkable
  def walk
    "I'm Walking"
  end
end

module Swimmable
  def swim
    "I'm swimming"
  end
end

module Climable
  def climb
    "I'm climbing"
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak"
  end
end

class GoodDog < Animal
  include Swimmable
  include Climable
end

p fido = Animal.new
p fido.speak

p fido.walk

puts GoodDog.ancestors