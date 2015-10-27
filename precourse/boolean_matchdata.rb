def has_a_b?(string)
  if /b/.match(string)
    puts "match"
  else
    puts "no match"
  end
end

has_a_b?("basketball")
has_a_b?("golf")