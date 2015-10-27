#Player and Dealer play a card game where the main objective is to hit 21, or come as close to possible without going over "busting". Both the player and the dealer are dealt 2 cards. All face cards are worth whatever numerical value they show. Suit cards are worth 10. Aces can be worth either 11 or 1. Example: if you have a Jack and an Ace, then you have hit "blackjack", as it adds up to 21.
#After receiving the first 2 cards, the player can hit (receive another card) or stay. If the player stays, it's the dealer's turn.
#The dealer has to hit until she has at least 17. 
#If the player's sum is 21, then the player wins.
#If the dealer, hits 21, then the dealer wins. If, however, the dealer stays, then we compare the sums of the two hands between the player and dealer; higher value wins.
#Get the player's Name and use it throughout the app
#Play Again?
#Save the card and the Suit
#Use multiple decks

# Card
# - number
# - Suit
# - Return human name

# Dealer < Player
# - Hit or Stay based on score < 17

# Game
# - Hand out cards
# - Calculate total for user
# - Calculate total for computer
# - Check for winner
# - Loop Hit or Stay user
# - Check for Winner
# - Hit or stay computer
# - Check for a winner
# - If there is a winner - show the winner, 
# - else it's a tie
# - Play again?

# Deck < Array
# - Number of decks
# - Cards in the decks
# - Deal from the deck

#Hand
# - Card Total
# -Show Hand

# Player/dealer
# - Hand / value of cards

require 'rubygems'
require 'pry'

class Card

  attr_accessor :suit, :number

  def initialize(suit,number)
    @number = number
    @suit = suit
  end

  def to_s 
    card_number = number
    card_number = case card_number
      when 1 then 'Ace'
      when 'K' then 'King'
      when 'Q' then 'Queen'
      when 'J' then 'Jack'
      else card_number
    end
    return "#{card_number} of #{suit.capitalize}"
  end

  def value
    card_value = number
    if %w(J Q K).include? card_value
      card_value = 10
    elsif card_value == 1
      card_value = 11
    end
    card_value
  end

end

class Deck < Array

  CARD_NUMBERS = [1,2,3,4,5,6,7,8,9,10,'J','Q','K']
  CARD_SUITS = ['hearts','diamonds','clubs','spades']

  def initialize(num_decks=1)
    num_decks.times do
      CARD_SUITS.each do |suit|
        CARD_NUMBERS.each do |number|
          self << Card.new(suit, number)
          self.shuffle!
        end
      end
    end
  end

  def deal_card
    self.pop
  end

end

module Hand

  def optimum_score
    total = 0
    players_cards.each do |card|
      total += card.value
    end

    num_aces = (players_cards.select{|card| card.value == 11}).length

    while total > Game::BLACKJACK && num_aces > 0 do
      total -= 10
      num_aces -= 1
    end

    total

  end

  def show_hand
    humanized_hand = players_cards.map do |card|
      card.to_s
    end
    return "#{name}'s hand is #{humanized_hand.join(', ')} for a total of #{optimum_score}"
  end

  def add_card(card_dealt)
    players_cards << card_dealt
  end

  def busted?
    total > Game::BLACKJACK
  end

end

class Player

  include Hand
  attr_accessor :name, :players_cards

  def initialize
    @name = nil
    @players_cards = []
  end

end

class Dealer

  include Hand
  attr_accessor :name, :players_cards

  def initialize
    @name = "The House"
    @players_cards = []
  end

end

class Game

  BLACKJACK = 21
  MINIMUM_DEALER_HIT = 17

  attr_accessor :deck, :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def get_name
    puts "Hello, what is your name?"
    player.name = gets.chomp
  end

  def first_deal
    2.times do
      player.add_card(deck.deal_card)
      dealer.add_card(deck.deal_card)
    end
  end

  def show_cards
    puts player.show_hand
    puts "Dealer's first card is hidden, Dealer's second card is #{dealer.players_cards[1]}"
  end

  def check_for_win_or_lose

    player_score = player.optimum_score
    dealer_score = dealer.optimum_score

    if dealer_score > BLACKJACK
      puts "I've busted... I lost."
    elsif dealer_score == BLACKJACK
      puts "I hit blackjack and won! Better luck next time"
    elsif player_score > BLACKJACK
      puts "Sorry, you totally busted. I win this round"
    elsif player_score == BLACKJACK
      puts "Great job! You just hit blackjack and won!"
    elsif player_score & dealer_score > BLACKJACK
      puts "We both busted, we both lose"
    else 
      return "keep playing"
    end

    play_again

  end

  def player_turn

    puts "You score is #{player.optimum_score}"

    while check_for_win_or_lose == "keep playing" 
      puts "Do you to hit or stay?"
      answer = gets.chomp.upcase

      if !['HIT', 'STAY'].include?(answer)
        puts "Error: you must enter Hit or Stay"
        next
      end

      if answer == 'HIT'
        hit_card = deck.deal_card
        puts "You were dealt: #{hit_card}"
        player.add_card(hit_card)
        puts "Your new score is #{player.optimum_score}"
      else
        puts "Great your final score is #{player.optimum_score}"
        break
      end

    end
  end

  def dealer_turn

    puts "It's the dealer's turn"

    while dealer.optimum_score < MINIMUM_DEALER_HIT && check_for_win_or_lose == "keep playing"
      hit_card = deck.deal_card
      puts "I'm lower than 17, I have to hit again"
      dealer.add_card(hit_card)
      puts "My new score is #{dealer.optimum_score}"
    end

    puts "Dealer's new score is #{dealer.optimum_score}"

  end

  def check_for_winner

    if player.optimum_score == dealer.optimum_score
      puts "We tied! Hooray, everybody wins!"
    elsif player.optimum_score > dealer.optimum_score
      puts "You were closer to blackjack, you win!"
    elsif dealer.optimum_score > player.optimum_score
      puts "I was closer to blackjack, I win"
    end

    play_again

  end

  def play_again

    puts "Play again? Y or N"
    answer = gets.chomp.upcase

    if !['Y', 'N'].include?(answer)
      puts "Error: you must enter Y or N"
      play_again
    elsif answer == 'Y'
      puts "Starting new game..."
      puts ""
      deck = Deck.new
      player.players_cards = []
      dealer.players_cards = []
      start_game
    else
      puts "Later, Gator!"
      exit
    end

  end

  def start_game
    get_name if @player.name.nil?
    first_deal
    show_cards
    player_turn
    dealer_turn
    check_for_winner
  end
  
end

deck = Deck.new(2)

game = Game.new
game.start_game