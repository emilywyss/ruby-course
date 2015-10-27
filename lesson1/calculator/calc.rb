def text(message)
  puts "#{message}"
end

text "What's the first number?"
num1 = gets.chomp #chomp eliminates the new line

text "What's the second number?"
num2 = gets.chomp

text "1. Add 2. Subtract 3. Multiply 4. Divide"
operation = gets.chomp

if operation == '1'
  result = num1.to_i + num2.to_i
elsif operation == '2'
  result = num1.to_i - num2.to_i
elsif operation == '3'
  result = num1.to_i * num2.to_i
else
  result = num1.to_f / num2.to_i
end

text "Your answer is #{result}"

    