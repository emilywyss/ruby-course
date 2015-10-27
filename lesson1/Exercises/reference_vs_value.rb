a = [1, 2, 3, 4, 5, 5]

def this_method(arr) #method that does not mutate the caller
  arr.uniq
end

p this_method(a) #Array inside the method has no duolication of 5
p a #Array outside the method still duplicates the 5


def mutate_method(change) #this method will mutate the caller
  change.uniq! #This is a permanent change
end

p mutate_method(a) #No duplication of 5
p a #outside the method still no duplication of 5