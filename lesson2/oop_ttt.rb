class Board

  attr_accessor :grid

  def initialize()
    @grid = []
    (1..9).each {|place| @grid[place] = ' '}
    @grid
  end

  def draw_grid
    system 'clear'
    puts "#{@grid[1]} |#{@grid[2]} |#{@grid[3]} "
    puts "--+--+-- "
    puts "#{@grid[4]} |#{@grid[5]} |#{@grid[6]} "
    puts "--+--+-- "
    puts "#{@grid[7]} |#{@grid[8]} |#{@grid[9]} "
  end

  def get_empty_place_indexes
    empty_space_indexes = []
    @grid.each_with_index do |value, index| 
      empty_space_indexes << index if value == ' '
    end 
    return empty_space_indexes
  end

  def check_winner
    winning_lines = [[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7],[1,2,3],[4,5,6],[7,8,9]]
       
    winning_lines.each do |line|
      if @grid[line[0]] == 'X' && @grid[line[1]] == 'X' && @grid[line[2]] == 'X'
        return 'Player'
      elsif @grid[line[0]] == 'O' and @grid[line[1]] == 'O' and @grid[line[2]] == 'O'
        return 'Computer'
      end
    end
    return nil
  end 
end

class Player
  attr_accessor :choice

  def players_pick(obj)
    puts "Pick a square between 1 and 9"
    self.choice = gets.chomp.to_i
    obj.grid[choice] = 'X'
  end
end

class Computer <Player
  def comp_pick(obj)
    choice = obj.get_empty_place_indexes.sample
    obj.grid[choice] = 'O'
  end
end

class Game
  attr_accessor :board, :player, :computer

  def initialize 
    @board = Board.new()
    @player = Player.new
    @computer = Computer.new
  end

  def play
    begin
      board.draw_grid
      player.players_pick(board)
      computer.comp_pick(board)
      board.draw_grid
      winner = board.check_winner
    end until board.get_empty_place_indexes.empty? || winner

    if winner
      puts "#{winner} won!"
    else
      puts "It's a tie"
    end
  end
end

game = Game.new.play