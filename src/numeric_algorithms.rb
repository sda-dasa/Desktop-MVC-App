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
