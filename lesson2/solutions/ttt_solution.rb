#Two approaches to OOP
#1. Extract classes and objects from existing code
#2. Write out a description of the program. Extract nouns from the description and group common verbs into the nouns

# What is a tic tac toe game
# A board game with 2 players
# A 9 space 3X3 grid that is empty. One player is 'O' and the other player is 'X'. The 'X' player goes first. The players alternate marking empty squares until a player gets 3 squares in a row. If all the squares are taken and nobody wins, then it is a tie.

# board
#   - squares
#   - Assign a position to it
#   - all squares marked?
#   - find all empty squares
# player1
#   - name?
#   - marker
# square
#   - Occupied?
#   - Mark with a marker

#game engine
  # Draw a board
  # Assign a player to X
  # Assign computer to O
  # Loop until a winner or all squares are taken
  # Player picks an empty square
  # Check for a winner
  # If there is a winner, show the winner
  # Or else
  # It's a tie

class Board
  WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
  
  def initialize
    @data = {} 
    (1..9).each {|position| @data[position] = Square.new(' ')}
  end

  def draw
    system 'clear'
    puts "#{@data[1]} |#{@data[2]} |#{@data[3]} "
    puts "--+--+-- "
    puts "#{@data[4]} |#{@data[5]} |#{@data[6]} "
    puts "--+--+-- "
    puts "#{@data[7]} |#{@data[8]} |#{@data[9]} "
  end

  def all_squares_marked?
    empty_squares.size == 0
  end

  def empty_squares
    @data.select {|_, square| square.empty?}.values
  end

  def empty_positions
    @data.select {|_, square| square.empty?}.keys
  end

  def mark_square(position, marker)
    @data[position].mark(marker)
  end

  def three_squares_in_a_row?(marker)
    WINNING_LINES.each do |line|
      return true if @data[line[0]].value == marker && @data[line[1]].value  == marker && @data[line[2]].value == marker
    end
    false
  end

end


class Square
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def mark(marker)
    @value = marker
  end

  def occupied?
    @value != ' '
  end

  def empty?
    @value == ' '
  end

  def to_s
    @value
  end
end

class Player
  attr_reader :marker, :name
  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Game
  def initialize
    @board = Board.new
    @human = Player.new("Emily", "X")
    @computer = Player.new("Jane", "O")
    @current_player = @human
  end

  def current_player_marks_square
    if @current_player == @human
      begin
        puts "Choose a position (1-9): "
        position = gets.chomp.to_i
      end until @board.empty_positions.include?(position)
    else
      position = @board.empty_positions.sample
    end
    @board.mark_square(position, @current_player.marker)
  end

  def current_player_wins?
    @board.three_squares_in_a_row?(@current_player.marker)
  end

  def alternate_player
    if @current_player == @human
      @current_player = @computer
    else
      @current_player= @human
    end
  end

  def play
    @board.draw
    loop do
      current_player_marks_square
      @board.draw
      if current_player_wins?
        puts "The winner is #{@current_player.name}!"
        break
      elsif @board.all_squares_marked?
        puts "It's a tie."
        break
      else
        alternate_player
      end
    end
    puts "Bye"
  end
end

Game.new.play