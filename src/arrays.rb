def find_unique_element(array)
  array.min_by{|el| array.count(el)}
end

def two_min_elements (array)
  array.sort[0..1]
end


def find_closest_element (array, r)
  if array.empty? then return 0 end
  array_of_deviation = array.map {|el| (el - r).abs}
  array[array_of_deviation.find_index(array_of_deviation.min)]
end


def find_divisors(el)
  (1..el).select{|i| el % i == 0}
end

def unique_positive_divisors (array)
  array.flat_map {|el| find_divisors(el)}.to_set.to_a
end


def squared_frequent_non_negative (array)
  array.select{|el| el >= 0 && el < 100 && array.count(el) > 2}.to_set.map{|el| el ** 2}
end

