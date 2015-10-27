#method to calculate the total
def calculate_total(cards)
  #[['s','v'],['s','v']...] the way the cards come in
  arr = cards.map{|e| e[1] }
  total = 0
  arr.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0
      total += 10
    else
      total += value.to_i
    end
  end
  #correct for aces
  arr.select{|e| e == "A"}.count.times do 
    total -= 10 if total > 21
  end
  total
end

#start the game
puts "welcome to blackjack"

suits = ['H','D','S','C']

cards = ['2','3','4','5','6','7','8','9','10','J','Q','K','A',]

deck = suits.product(cards)
deck.shuffle!

#deal cards
mycards = []
dealercards = []

mycards << deck.pop
dealercards << deck.pop
mycards << deck.pop
dealercards << deck.pop

#calculate the total from the method above
dealertotal = calculate_total(dealercards)
mytotal = calculate_total(mycards)

#Show cards
puts "dealer has: #{dealercards[0]} and #{dealercards[1]} for a total of #{dealertotal}"
puts "You have: #{mycards[0]} and #{mycards[1]} for a total of #{mytotal}"

#-------------player turn--------------
if mytotal == 21
  puts "congratulations, you hit blackjack, you win!"
  exit #ends the program
end

while mytotal < 21
  puts "What would you like to do? 1) for hit 2) for stay"
  hit_or_stay = gets.chomp.to_i
  if ['1','2'].include?(hit_or_stay)
    puts "Error: you must enter 1 or 2"
    next #goes to the next iteration of this loop and stops this one
  end
  if hit_or_stay == '2'
    puts "you chose to stay"
    break #breaks the loop
  end
  #hit
  new_card = deck.pop
  puts "Dealing card to player: #{new_card}"
  mycards << new_card
  mytotal = calculate_total(mycards)
  puts "your total is now #{mytotal}"

  if mytotal == 21
    puts "congratulations you hit blackjack, you win!"
    exit
  elsif mytotal > 21
    puts "Sorry, you busted"
    exit
  end
end

#--------------dealer turn--------------
if dealertotal == 21
  puts "Sorry, dealer hit blackjack, you lose"
  exit
end

while dealertotal < 17
  #hit
  new_card = deck.pop
  puts "dealing new card for dealer: #{new_card}"
  dealercards << new_card
  dealertotal = calculate_total(dealercards)
  puts "dealer total is now #{dealertotal}"

  if dealertotal == 21
    puts "Sorry, dealer hit blackjack, you lose"
    exit
  elsif dealertotal > 21
    puts "congratulations, dealer busted, you win"
    exit
  end
end

#compare hands

puts "Dealer's cards: "
dealercards.each do |card|
  puts "=>#{card}"
end

puts "you cards:"
mycards.each do |card|
  puts "=> #{card}"
end

if dealertotal > mytotal
  puts "Sorry, dealer won"
elsif dealertotal < mytotal
  puts "congratulations, you win"
else
  puts "it's a tie"
end
  