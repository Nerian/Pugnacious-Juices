require 'benchmark' 

EMPTY = 0
MOLECULE = 1

str = Benchmark.measure do
  10_000_000.times do
    "test" == 'tesu'
  end
end.total

sym = Benchmark.measure do
  10_000_000.times do
    :test == :test
  end
end.total

num = Benchmark.measure do
  10_000_000.times do
    2 == 3
  end
end.total

con = Benchmark.measure do
  10_000_000.times do
    MOLECULE == EMPTY
  end
end.total

puts "String: " + str.to_s
puts "Symbol: " + sym.to_s
puts "Number: " + num.to_s
puts "Constant: " + num.to_s
puts

Move 0.009999999999999787
Move 0.009999999999999787

Move 0.00999999999999801
