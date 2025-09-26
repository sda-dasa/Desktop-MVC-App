class Student
	def initialize (first_name: , last_name: , patronymic: nil, phone: nil, telegram: nil, email: nil, git: nil, id: nil) 
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

		if valid_patronymic? patronymic
			then @patronymic= patronymic
		else 
			puts "Отчество введено не корректно!"
		end
		if valid_phone? phone
			then @phone = phone
		else 
			puts "Телефон введен не корректно!"
		end

		if valid_telegram? telegram
			then @telegram = telegram
		else 
			puts "tg-никнейм введен не корректно!"
		end
		if valid_email? email
			then @email = email
		else 
			puts "Адрес электронной почты введен не корректно!"
		end

		if valid_git? git
			then @git = git
		else 
			puts "git введен не корректно!"
		end
		if id.nil? or id > 0
			then @id = id
		else 
			puts "id должен быть не отрицательным числом!"
		end

	end

	
	def first_name=(val)
		if valid_name? val
			then @first_name = val
		else 
			puts "Имя введено не корректно!"
		end
	end

	def last_name=(val)
		if valid_name? val  
			then @last_name = val
		else 
			puts "Фамилия введена не корректно!"
		end
	end

	def patronymic=(val)
		if valid_patronymic? val
			then @patronymic = val
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
		if !@telegram.nil? 
			return "tg: #{@telegram}"
		elsif !@email.nil? 
			return "email: #{@email}"
		elsif !@phone.nil? 
			return "phone: #{@phone}"
		else 
			puts "Контакты не указаны"
			return nil
		end	
	end

	def contact=(contacts)
		contacts.each do |key, value|
      			case key
      				when :phone 
					if valid_phone? value
						then @phone = value 
					end
      				when :email 
					if valid_email? value
						then @email = value 
					end
				when :telegram 
					if valid_telegram? value
						then @telegram = value 
					end
			end
		end
	end

	attr_reader :id, :first_name, :last_name, :surname, :git

	def last_name_initials
		if @patronymic.nil?
			then return "#{@last_name} #{@first_name[0]}."
		end
		return "#{@last_name} #{@first_name[0]}.#{@patronymic[0]}."
	end
	
	def to_s 
		return "last_name: #{@last_name} first_name: #{@first_name} patronymic: #{@patronymic} phone: #{@phone} mail: #{@mail} tg: #{@tg} git: #{@git} "
	end

	def short_info
		if !@id.nil?
		if !@telegram.nil? 
			return "id: #{@id} last_name_initials: #{last_name_initials} tg: #{@telegram} git: #{@git}"
		elseif !@email.nil? 
			return "id: #{@id} last_name_initials: #{last_name_initials} email: #{@email} git: #{@git}"
		elsif !@phone.nil?
			return "id: #{@id} last_name_initials: #{last_name_initials} phone: #{@phone} git: #{@git}"
		else 
			return "id: #{@id} last_name_initials: #{last_name_initials} git: #{@git}"
	
		end

		end
		if !@telegram.nil?  
			return "last_name_initials: #{last_name_initials} tg: #{@telegram} git: #{@git}"
		elsif !@email.nil? 
			return "last_name_initials: #{last_name_initials} email: #{@email} git: #{@git}"
		elsif !@phone.nil? 
			return "last_name_initials: #{last_name_initials} phone: #{@phone} git: #{@git}"
		else 
			return "id: #{@id} last_name_initials: #{last_name_initials} git: #{@git}"
		end
		
	end

	def has_contact?
		!@telegram.nil?or !@email.nil?or !@phone.nil?
	end

	def has_git?
		return!@git.nil?
	end


	def valid_name? (value)
		regex = /\A[A-Za-zА-Яа-яёЁ]+\z/
		if  value.match?(regex)
			then return true
		end
		return false
	end

	def valid_patronymic? (value)
		regex = /\A[A-Za-zА-Яа-яёЁ]+\z/
		if  value.nil? or value.match?(regex)
			then return true
		end
		return false
	end
	
	def valid_phone? (value)
		regex = /\A8[0-9]{10}\z/
		if  value.nil? or value.match?(regex)
			then return true
		end
		return false
	end		
	
	def valid_telegram? (value)
		regex = /\A@?[a-zA-Z0-9_]{5,32}\z/
		if value.nil? or  value.match?(regex)
			then return true
		end
		return false
	end
	
	def valid_email? (value)
		regex = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i
		if  value.nil? or value.match?(regex)
			then return true
		end
		return false
	end

	def valid_git? (value)
		regex = %r{\Ahttps://github\.com/[a-zA-Z0-9_-]{1,39}(/[a-zA-Z0-9_-]{1,100})?/?\z}
		if value.nil? or value.match?(regex)
			then return true
		end
		return false
	end
end
