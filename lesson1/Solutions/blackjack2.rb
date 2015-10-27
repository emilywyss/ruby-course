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

#Create Decks
card_values = [1,2,3,4,5,6,7,8,9,10,'J','Q','K']
card_suits = ['hearts','diamonds','clubs','spades']

def get_card_number(card)
  return card[0]
end

def get_card_suit(card)
  return card[1]
end

#Get human readable name for card
def get_humanized_card(card)
  card_value = get_card_number(card)
  card_value = case card_value
    when 1 then 'Ace'
    when 'K' then 'King'
    when 'Q' then 'Queen'
    when 'J' then 'Jack'
    else card_value
  end
  return "#{card_value} of #{get_card_suit(card).capitalize}"
end

def get_humanized_hand(hand)
  humanized_hand = hand.map do |card|
    get_humanized_card(card)
  end
  return humanized_hand.join(', ')
end

#Set up methods outside of loop
def play_again?
  puts "do you want to play again? (y/n)"
  ans = gets.chomp.downcase
  if ans != 'y'
    exit
  end
end

#getting the optimum hand score, accounting for aces
def get_optimum_hand_score(hand)
  total = 0
  hand.each do |card|
    total += get_card_value(card)
  end

  #Count the number of aces we have
  num_aces = (hand.select{|card| get_card_value(card) == 11}).length

  #Account fo aces
  while total > 21 && num_aces > 0 do
    total -= 10
    num_aces -= 1
  end
  return total
end


#Get numeric value of cards, accounting for face cards
def get_card_value(card)
  card_number = get_card_number(card)
  if card_number == 'K' || card_number == 'J' || card_number == 'Q'
    card_number = 10
  elsif card_number == 1
    card_number = 11
  end
  return card_number
end

#redrawing cards and hitting, returns the value of card of you got hit with
def hit(hand, deck, player_name='')
  hit = deck.pop
  puts "#{player_name} drew a: \n#{get_humanized_card(hit)}" unless player_name.strip() == ''
  hit_value = get_card_value(hit)
  hand << hit
  return hit_value
end

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

def check_score_end(comp_score,user_score)
  if user_score == comp_score
    puts "We tied! Hooray, everybody wins!"
  elsif user_score > comp_score
    puts "You were closer to blackjack, you win!"
  elsif comp_score > user_score
    puts "I was closer to blackjack, I win"
  end
end

loop do
  playing_deck = (card_values.product(card_suits)*2).shuffle

  comp_hand = []
  user_hand = []

  2.times do
    hit(user_hand,playing_deck)
    hit(comp_hand,playing_deck)
  end

  puts "Your hand is:\n#{get_humanized_hand(user_hand)} \nJane's hand is:\n#{get_humanized_hand(comp_hand)}"

  current_score = check_score(get_optimum_hand_score(comp_hand),get_optimum_hand_score(user_hand))

  unless current_score == "keep playing"
    next play_again?
  end

  puts "You score is #{get_optimum_hand_score(user_hand)} and my score is #{get_optimum_hand_score(comp_hand)}."

  #User takes turn
  until get_optimum_hand_score(user_hand) >= 21
    puts "Do you to hit or stay? (H or S)"
    answer = gets.chomp.upcase
    if answer == 'H'
      hit(user_hand,playing_deck,"you")
      puts "Your new score is #{get_optimum_hand_score(user_hand)}"
    else
      puts "Great your final score is #{get_optimum_hand_score(user_hand)}"
      break
    end
  end

  current_score = check_score(get_optimum_hand_score(comp_hand),get_optimum_hand_score(user_hand))

  unless current_score == "keep playing"
    next play_again?
  end

  #Pooder takes turn
  while get_optimum_hand_score(comp_hand) <17
    puts "I'm lower than 17, I have to hit again"
    hit(comp_hand,playing_deck,"I")
    puts "My new score is #{get_optimum_hand_score(comp_hand)}"
  end

  current_score = check_score(get_optimum_hand_score(comp_hand),get_optimum_hand_score(user_hand))

  unless current_score == "keep playing"
    next play_again?
  end

  check_score_end(get_optimum_hand_score(comp_hand),get_optimum_hand_score(user_hand))
  next play_again?

end