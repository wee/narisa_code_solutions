def find_prime_factors(number)
  first_prime_number = (2..Math.sqrt(number).to_i).find { |i| number % i == 0 }
  return [number] if first_prime_number.nil?
  [first_prime_number] + find_prime_factors(number / first_prime_number)
end

(2..100).each do |number|
  puts "Prime factors of #{number} is #{find_prime_factors(number).uniq.inspect}"
end
