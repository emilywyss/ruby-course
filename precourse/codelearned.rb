<!--get a name and return a value from it with a greeting-->

input = gets.chomp

def greeting(name)
  name + "? Nice to meet you"
end

returned_value = greeting(input)
puts returned_value
