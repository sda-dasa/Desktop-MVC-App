def non_three_divs (numb)
i = 1
count = 0
while i <= numb
	if i%3==0 
		then i = i + 1
	end
	if numb%i==0 
		then count = count + 1 
	end
i = i + 1
end 
return count
end

#puts "Вводи число"
#a = gets.chomp.to_f
#puts non_three_divs a


def min_odd_digit (a)
min_numb = 10
i = a
while i !=0
	curr_numb = i % 10
	if curr_numb % 2 == 1 and curr_numb < min_numb
		then min_numb = curr_numb
	end
	
	i = (i - curr_numb) / 10
end

return min_numb
end

#puts "Вводи число"
#a = gets.chomp.to_f
#puts min_odd_digit a

def have_common_divisors? (numb_1, numb_2)
comon_divisor = 1
max = if numb_1 > numb_2 then numb_1 else numb_2 end
k = 1
while k <= max and comon_divisor == 1
	if numb_1 % k == 0 and numb_2 % k == 0
		then comon_divisor = k
	end
k = k + 1
end

if comon_divisor != 1 
then return true
else return false
end

end

def special_divisors_sum (a)
sum_of_digits = 0
product_of_digits = 1
i = a
while i !=0
	curr_numb = i % 10
	sum_of_digits = sum_of_digits + curr_numb
	product_of_digits = product_of_digits * curr_numb
	
	i = (i - curr_numb) / 10
end
i = 1
sum = 0
while i <= a
if a % i == 0
	then	
	if have_common_divisors? product_of_digits, i and not have_common_divisors? sum_of_digits, i
		then sum = sum + i
	end
end
i = i + 1
end 

return sum

end


#puts "Вводи число"
#a = gets.chomp.to_f
#puts special_divisors_sum a


def which_method(method_number, way, *file_name)
	arg_for_any_method = 0
	case way
	when 0
		puts "Вводите число"
		arg_for_any_method = gets.chomp.to_f
	when 1
		if file_name.any? 
			if File.exist?(file_name[0]) 
				file = File.new(file_name[0] ,"r:UTF-8")
				arg_for_any_method = file.read.to_f
			else 
				puts " данного файла не существует. " +
				"Введите число с клавиатуры"
				arg_for_any_method = gets.chomp.to_f
			end
		else 
			puts "Введите путь к файлу"
			file_name  = gets.chomp
			if File.exist?(file_name) 
				file = File.new(file_name ,"r:UTF-8")
				arg_for_any_method = file.read.to_f
			
			else 
				puts " " "данного файла не существует. 
				Введите число с клавиатуры" " "
				arg_for_any_method = gets.chomp.to_f
			end
		end
	end
	case method_number
	when 1
		puts puts non_three_divs arg_for_any_method
	when 2
		puts min_odd_digit arg_for_any_method
	when 3
		puts special_divisors_sum arg_for_any_method	
	end

end

which_method 1, 0
which_method 1, 1, "new.txt"
which_method 3, 1, "new.txt"














