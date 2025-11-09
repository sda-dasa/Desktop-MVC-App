class Student
	include Comparable
  
  NAME_REGEX= /\A[A-ZА-Я]{1}[a-zа-яё]+\z/
  PHONE_REGEX= /^(\+7|8)?[\s\-\(]?(\d{3})[\s\-\)]?(\d{3})[\s\-]?(\d{2})[\s\-]?(\d{2})$/
  TELEGRAM_REGEX= /\A@[a-zA-Z0-9_]{5,32}\z/
  EMAIL_REGEX= /\A[\w+\-.\+]+@[a-z\d\-]+(\.[a-z]+)+\z/i
  GIT_REGEX= %r{\Ahttps://git(hub)?(lab)?\.com/[a-zA-Z0-9_-]{1,39}(/[a-zA-Z0-9_-]{1,100})?/?\z}



	def self.valid_name? (value)
		if !value.nil? and value.match?(NAME_REGEX)
			then return true
		end
		return false
	end
	
	def self.valid_phone? (value)
		if  value.nil? or value_new.match?(PHONE_REGEX)
			then return true
		end
		return false
	end		
	
	def self.valid_telegram? (value)
		if value.nil? or  value.match?(TELEGRAM_REGEX)
			then return true
		end
		return false
	end
	
	def self.valid_email? (value)
		if  value.nil? or value.match?(EMAIL_REGEX)
			then return true
		end
		return false
	end

	def self.valid_git? (value)
		if value.nil? or value.match?(GIT_REGEX)
			then return true
		end
		return false
	end


	def initialize (first_name: , last_name: , patronymic: nil, phone: nil, telegram: nil, email: nil, git: nil, id: nil) 
		self.first_name= first_name
		self.last_name= last_name
		self.patronymic= patronymic
		self.contact= {phone: phone, telegram: telegram, email: email}
		self.git= git
	end

	
	def first_name=(val)
		if self.class.valid_name? val
			then @first_name = val
		else 
			raise ArgumentError.new ("имя введено не корректно!")
		end
	end

	def last_name=(val)
		if self.class.valid_name? val  
			then @last_name = val
		else 
			raise ArgumentError.new ("Фамилия введена не корректно!")
		end
	end

	def patronymic=(val)
		if self.class.valid_name? val
			then @patronymic = val
		else 
			raise ArgumentError.new ("Отчество введено не корректно!")
		end
	end

	def git=(val)
		if self.class.valid_git? val
			then @git = val
		else 
			raise ArgumentError.new ("git введен не корректно!")
		end
	end


	def contact
		if !@telegram.nil? 
			return "telegram - #{@telegram}"
		elsif !@email.nil? 
			return "email - #{@email}"
		elsif !@phone.nil? 
			return "phone - #{@phone}"
		else 
			puts "Контакты не указаны"
			return nil
		end	
	end

	def contact=(contacts)
		contacts.each do |key, value|
      			case key
      				when :phone 
					if self.class.valid_phone? value
						then @phone = value 
					else 
						raise ArgumentError.new ("телефон введен не корректно!")
					end
      				when :email 
					if self.class.valid_email? value
						then @email = value 
					else 
						raise ArgumentError.new ("почта введена не корректно!")
					end
				when :telegram 
					if self.class.valid_telegram? value
						then @telegram = value 
					else 
						raise ArgumentError.new ("telegram введен не корректно!")
					end
			end
		end
	end

	attr_reader :id, :first_name, :last_name, :patronymic, :git

	def last_name_initials
		if @patronymic.nil?
			then return "#{@last_name} #{@first_name[0]}."
		end
		return "#{@last_name} #{@first_name[0]}. #{@patronymic[0]}."
	end
	
	def to_s 
		return "last_name - #{@last_name} first_name - #{@first_name} patronymic - #{@patronymic} phone - #{@phone} email - #{@email} telegram - #{@telegram} git - #{@git} "
	end

	def short_info
		if !@id.nil?
		if !@telegram.nil? 
			return "id - #{@id} last_name_initials - #{last_name_initials} telegram - #{@telegram} git - #{@git}"
		elsif !@email.nil? 
			return "id - #{@id} last_name_initials - #{last_name_initials} email - #{@email} git - #{@git}"
		elsif !@phone.nil?
			return "id - #{@id} last_name_initials - #{last_name_initials} phone - #{@phone} git - #{@git}"
		else 
			return "id - #{@id} last_name_initials - #{last_name_initials} git - #{@git}"
	
		end

		end
		if !@telegram.nil?  
			return "last_name_initials - #{last_name_initials} telegram - #{@telegram} git - #{@git}"
		elsif !@email.nil? 
			return "last_name_initials - #{last_name_initials} email - #{@email} git - #{@git}"
		elsif !@phone.nil? 
			return "last_name_initials - #{last_name_initials} phone - #{@phone} git - #{@git}"
		else 
			return "id - #{@id} last_name_initials - #{last_name_initials} git - #{@git}"
		end
		
	end

	def has_contact?
		!@telegram.nil? or !@email.nil?or !@phone.nil?
	end

	def has_git?
		return !@git.nil?
	end 

	def <=>(other)
    if other.nil? or other.class != Student
      raise ArgumentException, "Could not compare ArrayProcessor with #{nil ? other.nil? : other.class}"
    end
    self.last_name <=> other.last_name
  end	


end
