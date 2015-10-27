#Create a grid with empty spaces that can be filled
#Assign user to X and computer to O
#Get Xs from the user and have them place them at some EMPTY point in the grid
#Have the Os randomly generate from the computer and goes on and empty point in the grid
#Wash, rinse, repeat (loop) UNTIL...
#If 3 xs or 3 os are in a row, then one of the players wins or all squares are taken (tie)
#If there's a winner, show the winner / else state it's a tie

#loop until a winner or all squares are taken
  #player1 picks an empty square
  #check for a winner – this is variable
  #player2 picks an empty square
  #check for a winner

#if there's a winner
  #show the winner
#or else
  #it's a tie

#puts "Welcome to tic tac toe, would you like to be X or O? Pick one (X/O)"

#user_symbol = gets.chomp.upcase

#if user_symbol == 'X'
#  computer_symbol = 'O'
#else
#  computer_symbol = 'X'
#end
#grid = {1=>" ",2=>" ",3=>" ",4=>" ",5=>" ",6=>" ",7=>" ",8=>" ",9=>" "}

require 'pry'

def init_grid
  g = {}
  (1..9).each {|place| g[place] = ' '}
  g
end

def draw_grid(g)
  system 'clear'
  puts "#{g[1]} |#{g[2]} |#{g[3]} "
  puts "--+--+-- "
  puts "#{g[4]} |#{g[5]} |#{g[6]} "
  puts "--+--+-- "
  puts "#{g[7]} |#{g[8]} |#{g[9]} "
end

def empty_place(g)
  g.select {|k,v| v == ' '}.keys #you just want the numbers 1-9 so calling .keys puts it into an array
end

def players_pick(g)
  puts "Pick a square between 1 and 9"
  place = gets.chomp.to_i
  g[place] = 'X'
end

def comp_pick(g)
  place = empty_place(g).sample
  g[place] = 'O'
end

# This doesn't work and I'm sad now
# def check_winner(g)
#   winning_lines = [[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7],[1,2,3],[4,5,6],[7,8,9]]
#   winning_lines[0..7].each do |line|
#     if g[line].include?(['X','X','X'])
#       return 'Player'
#     elsif g[line[0]] == 'O' and g[line[1]] == 'O' and g[line[2]] == 'O'
#       return 'Computer'
#     else
#       return nil
#     end
#   end
# end

def check_winner(g)
 winning_lines = [[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7],[1,2,3],[4,5,6],[7,8,9]]
   
 winning_lines.each do |line|
   if g[line[0]] == 'X' && g[line[1]] == 'X' && g[line[2]] == 'X'
     return 'Player'
   elsif g[line[0]] == 'O' and g[line[1]] == 'O' and g[line[2]] == 'O'
     return 'Computer'
   end
 end
 
 return nil
end


#Alternate Way Taras suggested

# def check_winner(g)
#  winning_lines = []
#  [[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7],[1,2,3],[4,5,6],[7,8,9]].each_with_index do |line, line_index|
#    winning_lines[line_index] = []
#    line.each do |grid_spot|
#      winning_lines[line_index] << g[grid_spot]
#    end
#  end
 
#  if winning_lines.include? ['X', 'X', 'X']
#    return 'Player'
#  elsif winning_lines.include? ['O', 'O', 'O']
#    return 'Computer'
#  end
 
#  return nil
# end


grid = init_grid #Keeps track of the state of the board
draw_grid(grid)

begin
  players_pick(grid)
  comp_pick(grid)
  draw_grid(grid)
  winner = check_winner(grid)
end until empty_place(grid).empty? || winner

if winner
  puts "#{winner} won!"
else
  puts "It's a tie"
end


