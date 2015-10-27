rps = ['rock', 'paper', 'scissors']
puts "Play Rock, Paper, Scissors"

def display_winning_message(winning_choice)
  case winning_choice
  when 'paper'
    puts "Paper wraps around rock"
  when 'rock'
    puts "Rock Smashes scissors"
  when 'scissors'
    puts "Scissors cut paper"
  end
end

loop do

  begin
    puts "Choose one: (R/P/S)"  
    user_choice = gets.chomp.upcase
  end until user_choice == 'R' || user_choice == 'P' || user_choice == 'S'

  if user_choice == 'R' 
    long_form_user = 'rock'
  elsif user_choice == 'P'
    long_form_user = 'paper'
  elsif user_choice == 'S'
    long_form_user = 'scissors'
  end
      
  comp_choice = rps.sample(1)

  if comp_choice == ['rock']
    long_form_comp = 'rock'
  elsif comp_choice == ['paper']
    long_form_comp = 'paper'
  elsif comp_choice == ['scissors']
    long_form_comp = 'scissors'
  end


  if long_form_user == long_form_comp
    puts "It's a tie game!"
  elsif long_form_user == 'rock' && long_form_comp == 'scissors' || long_form_user == 'paper' && long_form_comp == 'rock' || long_form_user == 'scissors' && long_form_comp == 'paper'
    display_winning_message(long_form_user)
    puts "You win!"
  else
    display_winning_message(long_form_comp)
    puts "You lose!"
  end

  puts "Play Again? (y/n)"
  break if gets.chomp.downcase != 'y'

end