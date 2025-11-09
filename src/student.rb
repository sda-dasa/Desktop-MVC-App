class Student
	include Comparable

  	private

	def self.validate_field(value)
		return true if value.nil? or value.empty?
		yield(value)
	end

	NAME_REGEX= /\A[A-ZА-Я]{1}[a-zа-яё]+\z/
	PHONE_REGEX= /^(\+7|8)?[\s\-\(]?(\d{3})[\s\-\)]?(\d{3})[\s\-]?(\d{2})[\s\-]?(\d{2})$/
	TELEGRAM_REGEX= /\A@[a-zA-Z0-9_]{5,32}\z/
	EMAIL_REGEX= /\A[\w+\-.\+]+@[a-z\d\-]+(\.[a-z]+)+\z/i
	GIT_REGEX= %r{\Ahttps://git(hub)?(lab)?\.com/[a-zA-Z0-9_-]{1,39}(/[a-zA-Z0-9_-]{1,100})?/?\z}

	def valid_and_set(attribute, value, field_name, required: true)
		if value.nil? && !required
			instance_variable_set("@#{attribute}", value)
		elsif value && yield(value)
			instance_variable_set("@#{attribute}", value)
		else
			raise ArgumentError, "Incorrect #{field_name} entry"
		end
	end

	def set_contact_values(phone:, telegram:, email:)
		valid_and_set(:phone, phone, "phone", required: false) { |elem| self.class.valid_phone?(elem) }
		valid_and_set(:telegram, telegram, "telegram", required: false) { |elem| self.class.valid_telegram?(elem) }
		valid_and_set(:email, email, "email", required: false) { |elem| self.class.valid_email?(elem) }
	end
	
	def get_main_contact
		[
			{ type: 'telegram', value: @telegram },
			{ type: 'email', value: @email },
			{ type: 'phone', value: @phone }
		].find { |contact| contact[:value] && !contact[:value].empty? }
	end

	public 

	def self.valid_name? (value)
		self.class.validate_field(value){|elem| elem.match?(NAME_REGEX)}
	end
	
	def self.valid_phone? (value)
		self.class.validate_field(value){|elem| elem.match?(PHONE_REGEX)}
	end		
	
	def self.valid_telegram? (value)
		self.class.validate_field(value){|elem| elem.match?(TELEGRAM_REGEX)}
	end
	
	def self.valid_email? (value)
		self.class.validate_field(value){|elem| elem.match?(EMAIL_REGEX)}
  	end

	def self.valid_git? (value)
		self.class.validate_field(value){|elem| elem.match?(GIT_REGEX)}
	end


	def initialize (first_name: , last_name: , patronymic: nil, phone: nil, telegram: nil, email: nil, git: nil, id: nil) 
		self.first_name= first_name
		self.last_name= last_name
		self.patronymic= patronymic
		self.contact= {phone: phone, telegram: telegram, email: email}
		self.git= git
	end

	
	def first_name=(val)
		valid_and_set(:first_name, val, 'name') {|elem| self.class.valid_name?(elem)}
	end

	def last_name=(val)
		valid_and_set(:last_name, val, 'last name') {|elem| self.class.valid_name?(elem)}
	end

	def patronymic=(val)
		valid_and_set(:patronymic, val, 'patronymic', required: false) {|elem| self.class.valid_name?(elem)}
	end

	def git=(val)
		valid_and_set(:git, val, 'Git', required: false) {|elem| self.class.valid_git?(elem)}
	end


  	def contact=(contacts)
		raise ArgumentError, "Expected Hash, given #{contacts.class}" unless hash.is_a?(Hash)
    	raise ArgumentError, "Expected 3 contacts, given #{contacts.length}" if contacts.length != 3 

    	valid_keys = [:phone, :telegram, :email]
    	invalid_keys = contacts.keys - valid_keys
        
    	raise ArgumentError, "Unknown type of contact #{invalid_keys.first}" if !invalid_keys.empty?
        
    	set_contact_values(phone: contacts[:phone], telegram: contacts[:telegram], email: contacts[:email])
	end


	def contact
    	existing_contact = get_main_contact
    	return nil unless existing_contact
    	"#{existing_contact[:type]} - #{existing_contact[:value]}"
	end
	
	attr_reader :id, :first_name, :last_name, :patronymic, :git

	def last_name_initials
		"#{@last_name} #{@first_name[0]}." if patronymic.nil?
    
		"#{@last_name} #{@first_name[0]}. #{@patronymic[0]}."
	end
	
	def to_s 
		result = []
		result << "id - #{id}"    
		result << "last_name - #{first_name}"
		result << "last_name - #{last_name}"
		result << "phone - #{@phone}"
		result << "telegram - #{@telegram}"
		result << "email - #{@email}"
		result << "git - #{@git}"
		result.join(",")		
	end

	def short_info
		result = []
		result << "ID: #{id}" if id
		result << "ФИО: #{last_name_initials}"
		result << "Телефон: #{@phone}" if contact_present?(@phone)
		result << "Телеграм: #{@telegram}" if contact_present?(@telegram)
		result << "Почта: #{@email}" if contact_present?(@email)
		result << "Git: #{git}" if has_git?
		result.join("\n")		
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
