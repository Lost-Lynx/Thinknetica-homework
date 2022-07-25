# frozen_string_literal: true

alphabet = {}
num = 0

('a'..'z').each do |i|
  alphabet[i] = num
  num += 1
end

puts alphabet
