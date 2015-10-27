#part 1

local_var = 5 #question 1

5.times do |n| 
  local_var = 6
end

puts local_var


def no_mutate_method(number) #question 2
  number = 9
end

a = 3
no_mutate_method(a)
puts a


l_var2 = [1, 2, 3, 3] #question 3
def mutate_method(obj)
  new_var = obj.uniq!
  p new_var
end

mutate_method(l_var2)


#part 2

5.times do |b|
  var = 1
end

puts var