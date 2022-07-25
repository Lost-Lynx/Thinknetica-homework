alphabet = {}
num = 0

('a'..'z').each do |i|
  if 'aeiou'.include?(i) 
    alphabet[i] = num
  end
  num += 1
end

puts alphabet
