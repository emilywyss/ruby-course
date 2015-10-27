def has_lab?(string)
  if string =~ /lab/
    # puts string
    return true
  end
  return false
end

has_lab?("laboratory")
has_lab?("experiment")
has_lab?("Pan's Labyrinth")
has_lab?("elaborate")
has_lab?("polar bear")