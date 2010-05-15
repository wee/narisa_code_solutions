class Puzzle2

  def initialize(operators = [:+, :-, :*, :/], find_all_solutions = false)
    @operators = operators
    @find_all_solutions = find_all_solutions
  end

  def find_solution(number, num_digits, expected_result)
    prefix_permutation(number, @operators, num_digits) do |input|
      puts "testing #{input.inspect}"
      #raise "cannot happend #{input.inspect}" unless valid_prefix_notation?(input)
      begin
        if evaluate(input) == expected_result
          yield pretty_print(input)
          return unless @find_all_solutions
        end
      rescue
      end
    end
  end

  private
  def evaluate(prefix_queue)
    queue = prefix_queue.clone
    result = prefix_node(queue) do |op, left, right|
      raise "invalid input" unless left.is_a? Fixnum and right.is_a? Fixnum and op.is_a? Symbol
      raise "divide result not integer" if op == :/ and left % right != 0
      left.send(op, right)
    end
    raise "queue is not a valid prefix notation" unless queue.empty?
    result
  end

  def pretty_print(prefix_queue)
    prefix_node(prefix_queue) do |op, left, right|
      "(#{left} #{op.to_s} #{right})"
    end
  end

  def valid_prefix_notation?(array)
    evaluate(array).is_a? Fixnum
  rescue
    false
  end

  def prefix_node(prefix_queue, &block)
    op = prefix_queue.shift
    left = prefix_queue.shift
    left = prefix_node(prefix_queue.unshift(left), &block) if left.is_a? Symbol
    right = prefix_queue.shift
    right = prefix_node(prefix_queue.unshift(right), &block) if right.is_a? Symbol
    block.call(op, left, right) 
  end

  # we know that prefix notation always start with an operator and ends with 2 numbers
#  def permute_by_brute_force(number, operators, &block)
#    values = operators + [number]
#    operators.each do |operator|
#      values.each do |second|
#        values.each do |third|
#          values.each do |forth|
#            values.each do |fifth|
#              values.each do |sixth|
#                values.each do |seventh|
#                  block.call [operator, second, third, forth, fifth, sixth, seventh, number, number]
#                end
#              end
#            end
#          end
#        end
#      end
#    end
#  end
  def prefix(queue, operators, number, remaining_operators, remaining_numbers, &block)
    #puts "queue = #{queue.inspect}, operators = #{remaining_operators} number = #{remaining_numbers}"
    if remaining_operators == 0
      block.call queue + (1..remaining_numbers).map { |each| number }
    else
      operators.each do |operator|
        new_queue = queue + [operator]
        prefix(new_queue, operators, number, remaining_operators - 1, remaining_numbers, &block) if remaining_operators > 0
        prefix(new_queue + [number], operators, number, remaining_operators - 1, remaining_numbers - 1, &block) if remaining_numbers > 0
      end
    end
  end

  def prefix_permutation(number, operators, num_digits, &block)
    num_operators = num_digits - 1
    prefix([], operators, number, num_operators - 1, num_digits, &block)
  end
end
