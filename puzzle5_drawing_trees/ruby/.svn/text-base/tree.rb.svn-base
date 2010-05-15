class Tree
  def initialize(array)
    @array = array
  end

  def to_s(array = nil, current_level = 0, levels = nil)
    array ||= @array
    levels ||= tree_levels(array.size)
    number_of_nodes_at_this_level = 2 ** current_level
    result = to_level(array[0...number_of_nodes_at_this_level], 
                      2 ** (levels - current_level + 1), 
                      current_level != 0, 
                      current_level != levels) 
    return result if current_level == levels
    result + to_s(array[number_of_nodes_at_this_level..-1], current_level + 1, levels) 
  end
  
  private

  def to_level(array, num_spaces, with_before = true, with_next = true)
    result = to_line(array, num_spaces)
    join_line = to_line(Array.new(array.size, '|'), num_spaces) if with_before or with_next
    result = between_level(array, num_spaces) + join_line + result if with_before
    result << join_line if with_next
    result
  end
  
  def to_line(array, num_spaces)
    result = array[0].to_s.rjust(num_spaces)
    result << array[1..-1].map { |each| each.to_s.rjust(num_spaces * 2) }.to_s if array.size > 1
    result << "\n"
  end
  
  def between_level(array, num_spaces)
    result = to_line(Array.new(array.size, '+'), num_spaces)
    filler = Toggle.new(nil, '-')
    plus_char = "+"[0]
    (0...result.length - 1).each do |index|
      if result[index] == plus_char
        filler.toggle
      else
        result[index] = filler.value unless filler.value.nil?
      end           
    end
    result
  end
    
  def tree_levels(number)
    # ruby 1.8 does not have Math.log2()
    (Math.log(number) / Math.log(2)).to_i
  end
end

class Toggle
  attr_reader :value
  
  def initialize(off_string, on_string)
    @off = off_string
    @on = on_string
    @value = off_string
  end
  
  def toggle
    @value = @value == @off ? @on : @off
  end
end

(1..16).each do |size|
  array = Array.new(size)
  array.each_with_index { |each, index| array[index] = index + 1 }
  puts Tree.new(array).to_s
end
puts Tree.new([12, 20, 15, 29, 23, 17, 22, 35, 40, 26, 51, 19]).to_s
