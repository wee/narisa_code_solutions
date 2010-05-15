class RomanNumeral
    ONE_DIGIT_MAPPINGS = { 1 => [1], 2 => [1,1], 3 => [1,1,1], 4 => [1, 5], 5 => [5],
                           6 => [5,1], 7 => [5,1,1], 8 => [5,1,1,1], 9=> [1, 10]
    }
    ROMAN_NUMERALS_ARRAY = [ {1 => 'I', 5 => 'V', 10 => 'X'}, 
                             {1 => 'X', 5 => 'L', 10 => 'C'},
                             {1 => 'C', 5 => 'D', 10 => 'M'}, 
                             {1 => 'M'} ]
        
    def initialize(number)
      @number = number.to_s
    end
    
    def to_string(reverse_array_of_digits, roman_numerals_array)
      digit = reverse_array_of_digits.shift.to_i
      roman_numerals = roman_numerals_array.shift
      unless reverse_array_of_digits.empty?
        result = to_string(reverse_array_of_digits, roman_numerals_array) 
      end
      return result if digit == 0
      (result || "") + ONE_DIGIT_MAPPINGS[digit].map { |each| roman_numerals[each] }.join
    end
    
    def to_s
      "#{@number} = #{to_string(@number.reverse.split(//), ROMAN_NUMERALS_ARRAY.clone)}"
    end
end

# use case from input array
#[2,9,15,49,53,75,76,106,150,199,373,558,981,999,1000,1005].each do |number|
#  puts RomanNumeral.new(number).to_s
#end

# use case from input file
IO.readlines('input4.txt').map do |line| 
  puts RomanNumeral.new(line.chomp).to_s
end
