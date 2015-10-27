module MyModule
  #grouping common methods
end

module NameSpace #namespaces the class
  class MyClass
    include MyModule
  end
end

my_obj = NameSpace::MyClass.new

