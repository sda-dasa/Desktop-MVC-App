def non_three_divs (numb)
i = 2
count = 0
while i < numb - 1
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
if min_numb == 10 
	then min_numb = nil
end
return min_numb
end



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
