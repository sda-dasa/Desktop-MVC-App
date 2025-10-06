def find_unique_element(array)
  array.drop_while{|i| i==array.first}.first
end

puts find_unique_element([1,1,1,1,3,1,1,1])

def two_min_elements (array)
  array.sort[0..1]
end

puts two_min_elements([89, 7, 3, 38, 8, -9, -11, -18 , 3 , 1 , 1 , 1])

def find_closest_element (r:, array:)
  array_of_deviation = array.map {|el| (el - r).abs}
  array[array_of_deviation.find_index(array_of_deviation.min)]
end

puts find_closest_element(r: -9.14, array: [-19, 0, 13, 11, 0, 0, -10, -24, 12])

def find_divisors(el)
  (2..el-1).select{|i| el % i == 0}
end

def unique_positive_divisors (array)
  array.flat_map {|el| find_divisors(el)}.to_set
end

puts unique_positive_divisors([11, 0, 12, 1, 5, 1, 36])


def square_frequent_non_negative (array)
  array.select{|el| el >= 0 && el < 100 && array.count(el) > 2}.to_set.map{|el| el ** 2}
end

puts square_frequent_non_negative([11, 0, 12, 1, 5, 1, 36, 1, 0, 0, 12, 12, 12]).class
