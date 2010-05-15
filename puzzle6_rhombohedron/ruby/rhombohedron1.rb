def draw_rhombohedron(num_lines)
  even = num_lines % 2 == 0
  width = even ? num_lines - 1 : num_lines
  half = fill_stars('-' * width, 0, width)
  bottom_half = even ? half : half[1..-1] # skip first line if num lines are even
  (half.reverse + bottom_half).join("\n")
end

def fill_stars(line_template, offset, width)
  return [] if offset > width / 2
  result = line_template.dup
  result[offset] = '*'
  result[width-offset-1] = '*'
  [result] + fill_stars(line_template, offset + 1, width)
end

#(3..10).each { |x| puts "n=#{x}"; puts draw_rhombohedron x }

require 'benchmark'
Benchmark.bm do |x|
  x.report { draw_rhombohedron 1000 }
end
