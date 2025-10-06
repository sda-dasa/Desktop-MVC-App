require_relative 'numeric_algorithms'

method_number = ARGV[0]
way = ARGV[1]
file_name = ARGV[2]
case way
when '0'
	puts "Вводите число"
	arg_for_any_method = STDIN.gets.chomp.to_f
when '1'
	if not file_name.nil?
		if File.exist?(file_name) 
			file = File.new(file_name ,"r:UTF-8")
			arg_for_any_method = file.read.to_f
		else 
			puts " данного файла не существует. " +
			"Введите число с клавиатуры"
			arg_for_any_method = STDIN.gets.chomp.to_f
		end
	else 
		puts "Введите путь к файлу"
		file_name  = STDIN.gets.chomp
		if File.exist?(file_name) 
			file = File.new(file_name ,"r:UTF-8")
			arg_for_any_method = file.read.to_f
		
		else 
			puts " " "данного файла не существует. 
			Введите число с клавиатуры" " "
			arg_for_any_method = STDIN.gets.chomp.to_f
		end
	end
else 
	puts 'Проблема: Аргумент 2: 0 - ввести данные с клавиатуры, 1 - считывать данные из файла. Других опций нет'
	puts "Введите число с клавиатуры"
	arg_for_any_method = STDIN.gets.chomp.to_f
end
case method_number
	when '1'
		puts "Делители не кратные трем: #{non_three_divs arg_for_any_method}"
	when '2'
		puts "Минимальная нечетная цифра: #{min_odd_digit arg_for_any_method}"
	when '3'
		puts "Сумма особенных делителей: #{special_divisors_sum arg_for_any_method}"
	else 
	puts 'Проблема: Аргумент 1: Такого метода в наличии нет'	
end
