def find_unique_element(array)
  result = array.min_by{|el| array.count(el)} != array.max_by{|el| array.count(el)} ? array.min_by{|el| array.count(el)} : nil
end

def two_min_elements (array)
  array.sort[0..1]
end


def find_closest_element (array, r)
  array_of_deviation = array.map {|el| (el - r).abs}
  index_ = array_of_deviation.find_index(array_of_deviation.min)
  result = if index_.nil? then nil else  array[index_] end
end



def find_divisors(el)
  (1..el).select{|i| el % i == 0}
end


def unique_positive_divisors (array)
  array.flat_map {|el| find_divisors(el)}.to_set.to_a.sort
end


def squared_frequent_non_negative (array)
  array.select{|el| (el.class == Integer || el.class == Float) && el >= 0 && el < 100 && array.count(el) > 2}.to_set.map{|el| el ** 2}
end
