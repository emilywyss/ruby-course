class Parent
  def say_hi
    p "Hi from Parent"
  end
end

class Child < Parent
  def say_hi
    p "Hi from Child"
  end

  def send
    p "send from Child"
  end

  def instance_of?
    p "I'm a fake instance"
  end
end

child = Child.new
child.say_hi

#Overriding Object's Send method below
# son = Child.new
# son.send :say_hi

# lad = Child.new
# lad.send :say_hi

c = Child.new
p c.instance_of? Child
p c.instance_of? Parent

p Parent.superclass