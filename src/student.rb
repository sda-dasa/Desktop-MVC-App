class Student
	def initialize (first_name: , last_name: , surname: nil, phone: nil, tg: nil, mail: nil, git: nil, id: nil) 
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

	
	def first_name=(val)
		if valid_first_name? val
			then @first_name = val
		else 
			puts "Имя введено не корректно!"
		end
	end

	def last_name=(val)
		if valid_last_name? val  
			then @last_name = val
		else 
			puts "Фамилия введена не корректно!"
		end
	end

	def surname=(val)
		if valid_surname? val
			then @surname = val
		else 
			puts "Отчество введено не корректно!"
		end
	end

	def git=(val)
		if valid_git? val
			then @git = val
		else 
			puts "Гит введен не корректно!"
		end
	end


	def contact
		case x
			when has_tg?
				return "tg: #{@tg}"
			when has_mail?
				return "mail: #{@mail}"
			when has_phone?
				return "mail: #{@phone}"
		end	
	end

	def contact=(contacts)
		contacts.each do |key, value|
      			case key
      				when :phone 
					if valid_phone? value
						then @phone = value 
					end
      				when :mail 
					if valid_mail? value
						then @mail = value 
					end
				when :tg 
					if valid_tg? value
						then @tg = value 
					end
			end
		end
	end

	attr_reader :id, :first_name, :last_name, :surname, :git

	def last_name_initials
		if @surname.nil?
			then return "#{@last_name} #{@first_name[0]}."
		end
		return "#{@last_name} #{@first_name[0]}.#{@surname[0]}."
	end
	
	def to_s 
		return "last_name: #{@last_name} first_name: #{@first_name} surname: #{@surname} 
phone: #{@phone} mail: #{@mail} tg: #{@tg} git: #{@git} "
	end

	def short_info
		if has_id?
		then case x
		when has_tg? 
			return "id: #{@id} last_name_initials: #{@last_name_initials} tg: #{@tg} git: #{@git}"
		when has_mail? 
			return "id: #{@id} last_name_initials: #{@last_name_initials} mail: #{@mail} git: #{@git}"
		when has_phone? 
			return "id: #{@id} last_name_initials: #{@last_name_initials} phone: #{@phone} git: #{@git}"
		end

		end
		case x
		when has_tg? 
			return "last_name_initials: #{@last_name_initials} tg: #{@tg} git: #{@git}"
		when has_mail? 
			return "last_name_initials: #{@last_name_initials} mail: #{@mail} git: #{@git}"
		when has_phone? 
			return "last_name_initials: #{@last_name_initials} phone: #{@phone} git: #{@git}"
		end
		
	end

	def has_tg?
		return not @tg.empty?
	end
	def has_mail?
		return not @mail.empty?
	end
	def has_phone?
		return not @phone.empty?
	end
	def has_git?
		return not @git.empty?
	end


	def valid_name? (value)
		regex = /\A[A-Za-zА-Яа-яёЁ]+\z/
		if  value.match?(regex)
			then return true
		end
		return false
	end

	def valid_surname? (value)
		regex = /\A[A-Za-zА-Яа-яёЁ]+\z/
		if  value.match?(regex) or value.nil?
			then return true
		end
		return false
	end
	
	def valid_phone? (value)
		regex = /\A8[0-9]{10}\z/
		if  value.match?(regex) or value.empty?
			then return true
		end
		return false
	end		
	
	def valid_tg? (value)
		regex = /\A@?[a-zA-Z0-9_]{5,32}\z/
		if  value.match?(regex) or value.empty?
			then return true
		end
		return false
	end
	
	def valid_mail? (value)
		regex = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i
		if  value.match?(regex) or value.empty?
			then return true
		end
		return false
	end

	def valid_git? (value)
		regex = /\A[a-zA-Z0-9_-]+\z/
		if  value.match?(regex) or value.empty?
			then return true
		end
		return false
	end

	def valid_id? (value)
		if value.nil? or value.to_f != nil and value.to_f >= 0 
			then return true
		end
		return false
	end

end
