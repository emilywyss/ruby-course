#Create a deck of cards using suits and values (you can use more than one deck) - check
#Get the users name and define 2 users, comp and user - check
#Assign a value to the queen king jack - semi-check
#hand out 2 cards from the deck to both comp and user and give those users hands - check
#check total of comp and of user - check
#if <17 the dealer must deal again
#if it equals 21 - user wins
#else if != 21 keep playing or stay
#else if it's >21 the game is lost
#Whoever is closest to 21 at their stay w/o going over wins
#Ask if they want to play again

puts "Hello, what is your name?"
name = gets.chomp
comp_name = "Jane"
puts "Hi #{name}, nice to meet you! I'm #{comp_name}. Let's get started."

loop do

  def play_again?
    puts "do you want to play again? (y/n)"
    ans = gets.chomp.downcase
    if ans != 'y'
      exit
    end
  end

  deck = [1,2,3,4,5,6,7,8,9,10,'J','Q','K']
  suits = ['hearts','diamonds','clubs','spades']

  playing_deck = (deck.product(suits)*2).shuffle

  comp_hand = []
  user_hand = []

  2.times do
    user_hand << playing_deck.pop
    comp_hand << playing_deck.pop
  end

  puts "Your hand is #{user_hand} and Jane's hand is #{comp_hand}"

  #Code to Refactor:

  # user_values = []
  # comp_values = []

  # user_hand.map do |value|
  #   card_number = value.first
  #   if card_number == 'K' || card_number == 'J' || card_number == 'Q'
  #     card_number = 10
  #   elsif card_number == 1
  #     card_number = 11
  #   end
  #   user_values << card_number
  # end

  # comp_hand.map do |value|
  #   card_number = value.first
  #   if card_number == 'K' || card_number == 'J' || card_number == 'Q'
  #     card_number = 10
  #     elsif card_number == 1
  #     card_number = 11
  #   end
  #   comp_values << card_number
  # end

  #Refactored Code:

  def find_value(hand)
    hand.map do |value|
    card_number = value.first
      if card_number == 'K' || card_number == 'J' || card_number == 'Q'
        card_number = 10
      elsif card_number == 1
        card_number = 11
      end
    card_number
   end
  end

  user_values = find_value(user_hand)
  comp_values = find_value(comp_hand)

  #BOOYEAH

  #Code block 2 to refactor

  # user_total = 0
  # comp_total = 0

  # user_values.each do |card|
  #   user_total += card
  #   if user_total > 21 && card == 11
  #     user_total -= 10
  #   end
  # end

  # comp_values.each do |card|
  #   comp_total += card
  #   if comp_total > 21 && card == 11
  #     comp_total -= 10
  #   end
  # end

  #Refactored Code

#Handling Aces
  def calculate_score(values)
    total = 0
    values.each do |card|
      total += card
      if total > 21 && card == 11
        total -= 10
      end
    end
    total
  end

  user_total = calculate_score(user_values)
  comp_total = calculate_score(comp_values)

  def check_score(comp_score,user_score)
    if comp_score > 21
      puts "I've busted... I lost."
    elsif comp_score == 21
      puts "I hit blackjack and won! Better luck next time"
    elsif user_score > 21
      puts "Sorry, you totally busted. I win this round"
    elsif user_score == 21
      puts "Great job! You just hit blackjack and won!"
    else 
      return "keep playing"
    end
  end


  current_score = check_score(comp_total,user_total)

  unless current_score == "keep playing"
    next play_again?
  end


  #AWEEEYEAAHHHH


  puts "You score is #{user_total} and my score is #{comp_total}."

  until user_total >= 21
  puts "Do you to hit or stay? (H or S)"
  answer = gets.chomp.upcase
    if answer == 'H'
      hit = []
      hit << playing_deck.pop
      p hit
      hit_value = find_value(hit)
      hit_total = calculate_score(hit_value)
      user_total += hit_total
      puts "Your new score is #{user_total}"
    else
      puts "Great your final score is #{user_total}"
      break
    end
  end

  current_score = check_score(comp_total,user_total)

  unless current_score == "keep playing"
    next play_again?
  end


  while comp_total <17
    puts "I'm lower than 17, I have to hit again"
    hit = []
    hit << playing_deck.pop
    p hit
    hit_value = find_value(hit)
    hit_total = calculate_score(hit_value)
    comp_total += hit_total
    if comp_total < 21
    puts "My new score is #{comp_total}"
    end
  end


  current_score = check_score(comp_total,user_total)
  unless current_score == "keep playing"
    next play_again?
  end

  def check_score_end(comp_score,user_score)
    if user_score == comp_score
      puts "We tied! Hooray, everybody wins!"
    elsif user_score > comp_score
      puts "You were closer to blackjack, you win!"
    elsif comp_score > user_score
      puts "I was closer to blackjack, I win"
    end
  end

  check_score_end(comp_total,user_total)
  next play_again?

end


