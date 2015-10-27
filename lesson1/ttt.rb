#Create a grid with empty spaces that can be filled
#Get Xs from the user and have them place them at some point in the grid
#Have the Os randomly generate from the computer
#If 3 xs or 3 os are in a row, then one of the players wins

#Create the grid
grid = {'1'=>" ",'2'=>" ",'3'=>" ",'4'=>" ",'5'=>" ",'6'=>" ",'7'=>" ",'8'=>" ",'9'=>" "}

winning = [['1','4','7'],['2','5','8'],['3','6','9'],['1','5','9'],['3','5','7']]

def init_grid
  grid = {}
  (1..9).each {|place| grid[place] = ' '}
  return grid
end

def draw_grid(board)
  puts 


#Get user symbol
puts "Welcome to tic tac toe, would you like to be X or O? Pick one (X/O)"

user_symbol = gets.chomp.upcase

if user_symbol == 'X'
  computer_symbol = 'O'
else
  computer_symbol = 'X'
end

puts "That's great. My name is Emmy, what's yours?"

user_name = gets.chomp
computer_name = "Emmy"

puts "Alright, #{user_name} is #{user_symbol} and #{computer_name} is #{computer_symbol}. You go first."

