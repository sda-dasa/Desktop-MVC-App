require_relative 'enumerable.rb'


def sum (array_processor)
  result = 0 
  array_processor.each do |el|
    result += el 
  end
  result
end

def sum_divisors(n)
  i = 1
  sum = 0
  while i < n-1
    if n % i == 0
      sum += i
    end
    i+=1
  end
  sum
end 

arr = ArrayProcessor.new([1,1,2,2,2,3,6])
new_arr = ArrayProcessor.new([17,12,30])
combined_arr = ArrayProcessor.new([3,31,23,"h7", "12", "jkl"])
string_arr= ArrayProcessor.new(["hu5uj77898", "16782", "jyioiykl"])
arr_1 = ArrayProcessor.new([1, 2, 3, 4])
new_arr_1 = ArrayProcessor.new([[1, 2], [3, 4]])

puts "checking the find method"
puts arr.find{ |i| i % 2 == 0 and i % 3 == 0 }

puts "min_by"
puts string_arr.min_by{|x| x.length}
puts string_arr.min_by{|x| x.length}.class

puts "sorting by sum of divisors of elements (all of them numbers)"
puts new_arr.sort{|x| sum_divisors(x)}
puts "sorting by object_id"
puts new_arr.sort{|x| x.object_id}
puts "sorting by object_id"
puts combined_arr.sort{|x| x.object_id}
puts "compairing two examples of ArrayProcessor by total sum of all elements for each examples by method <=>"
puts arr.<=>(new_arr){|arr| sum(arr)}
puts "compairing two examples of ArrayProcessor by their object_id by method <=>"
puts arr.<=>(new_arr){|arr| arr.object_id}

puts "finding the longest string using inject"
puts string_arr.inject("") {|memo, el| memo.length > el.length ? memo : el}
puts "appending object_id's into memo using inject"
puts string_arr.inject([]){|memo, el| memo.append(el.object_id)}

puts "adding negative element for each element in array using flat_map"
puts arr_1.flat_map { |e| [e, -e] }[0..4]
puts "adding 100 to each subarray in array using flat_map"
puts new_arr_1.flat_map{ |e| e + [100] }[0..4]

puts "checkind method all?"
puts combined_arr.all?{|elem| elem.class == String}
puts "checkind method all?"
puts string_arr.all?{|elem| elem.class == String}
puts "checkind method one?"
puts string_arr.one?{|elem| elem.length == 5}
puts "checkind method one?"
puts combined_arr.one?{|elem| elem.object_id > 35}