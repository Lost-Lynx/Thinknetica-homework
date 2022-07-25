fibonachi_numbers = [0, 1]

num_new = fibonachi_numbers[0] + fibonachi_numbers[1]
while num_new < 100
  fibonachi_numbers.push(num_new)
  num_new = fibonachi_numbers[fibonachi_numbers.size - 1] + fibonachi_numbers[fibonachi_numbers.size - 2]
end

puts fibonachi_numbers
