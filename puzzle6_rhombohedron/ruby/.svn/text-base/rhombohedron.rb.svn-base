def draw_rhombohedron(lines)
  even = lines % 2 == 0
  width = lines
  width -= 1 if even
  line = '-' * width + "\n"
  half = fill_stars(line, 0, width)
  bottom_half = even ? half : half[width+1..-1]
  "#{half.reverse}\n#{bottom_half}"
end

def fill_stars(line, offset, width)
  return "" if offset > width / 2
  result = line.dup
  result[offset] = '*'
  result[width-offset-1] = '*'
  "#{result}#{fill_stars(line, offset + 1, width)}"
end

#(1..10).each { |x| puts draw_rhombohedron x }

require 'benchmark'
Benchmark.bm do |x|
  x.report { draw_rhombohedron 1000 }
end
