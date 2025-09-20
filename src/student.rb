class Student
	def initialize (first_name, last_name, surname = nil, phone= nil, tg = nil, mail = nil, git = nil, id = nil) 
		if valid_name? first_name  
			then @first_name = first_name
		else 
			puts "Имя введено не корректно!"
		end
		if valid_name? last_name  
			then @last_name = last_name
		else 
			puts "Фамилия введена не корректно!"
		end

		if valid_surname? surname
			then @surname = surname
		else 
			puts "Отчество введено не корректно!"
		end
		if valid_phone? phone
			then @phone = phone
		else 
			puts "Телефон введен не корректно!"
		end

		if valid_tg? tg
			then @tg = tg
		else 
			puts "tg-никнейм введен не корректно!"
		end
		if valid_mail? mail
			then @mail = mail
		else 
			puts "Адрес электронной почты введен не корректно!"
		end

		if valid_git? git
			then @git = git
		else 
			puts "git введен не корректно!"
		end
		if valid_id? id
			then @id = id
		else 
			puts "id должен быть не отрицательным числом!"
		end

	end
