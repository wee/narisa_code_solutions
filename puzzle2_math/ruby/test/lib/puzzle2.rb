require 'array'

class Puzzle2

  def initialize(expected_result = 5, operators = [:+, :-, :*, :/])
    @expected_result = expected_result
    @operators = operators
  end
  
  def find_solutions(&block)
    (4..4).each do |number|
      find_solution(number, &block)
    end
  end

  def find_solution(number)
      permute(array_from_number(number), @operators) do |input|
        raise "stop here" if input == [:+, :+, 4, :/, 4, 4, :-, 4, 4]
        if valid_prefix?(input) and evaluate(input) == @expected_result
          yield pretty_print(input)
          return
        end
      end
  end

  def permute(values, operators)
    (operators + values).permute { |each| puts "#{each.inspect}"; yield each } if block_given?
  end

  def evaluate(prefix_queue)
    queue = prefix_queue.clone
    result = prefix(queue) do |op, left, right|
      raise "invalid input op = #{op.inspect} left = #{left.inspect} right = #{right.inspect}" unless left.is_a? Fixnum and right.is_a? Fixnum and op.is_a? Symbol
      left.send(op, right)
    end
    raise "queue is not a valid prefix notation" unless queue.empty?
    result
  end

  def pretty_print(prefix_queue)
    prefix(prefix_queue) do |op, left, right|
      "(#{left} #{op.to_s} #{right})"
    end
  end

  def valid_prefix?(array)
    evaluate(array).is_a? Fixnum
  rescue
    false
  end

  private
  def array_from_number(value)
    (1..5).inject([]) { |result, index| result << value }
  end

  def prefix(prefix_queue, &block)
    op = prefix_queue.shift
    left = prefix_queue.shift
    left = prefix(prefix_queue.unshift(left), &block) if left.is_a? Symbol
    right = prefix_queue.shift
    right = prefix(prefix_queue.unshift(right), &block) if right.is_a? Symbol
    #puts "input op = #{op.inspect} left = #{left.inspect} right = #{right.inspect}"
    block.call(op, left, right) #if op.is_a? Symbol and left.is_a? Fixnum and right.is_a? Fixnum
  end
end
