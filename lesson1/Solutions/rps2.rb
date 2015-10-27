CHOICES = {'r' => 'Rock', 'p' => 'Paper', 's' => 'Scissors' }

puts "Welcome to Rock,Paper,Scissors"

def display_winning_message(winning_choice)
  case winning_choice
  when 'p'
    puts "Paper wraps around rock"
  when 'r'
    puts "Rock Smashes scissors"
  when 's'
    puts "Scissors cut paper"
  end
end

loop do
  #player makes a pick
  begin
    puts "Choose one: (r/p/s)"
    player_choice = gets.chomp.downcase
  end until CHOICES.keys.include?(player_choice)

  #computer makes a pick
  computer_choice = CHOICES.keys.sample

  if player_choice == computer_choice 
    puts "It's a tie"
  #player wins?
  elsif player_choice == 'p' && computer_choice == 'r' || player_choice == 'r' && computer_choice == 's' || player_choice == 's' && computer_choice == 'p'
    display_winning_message(player_choice)
    puts "You win"
  #player loses?
  else
    display_winning_message(computer_choice)
    puts "You lose"
  end

  puts "Play Again? (y/n)"
  break if gets.chomp.downcase != 'y'
end

puts "Good Bye!"