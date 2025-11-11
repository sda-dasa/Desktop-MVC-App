require_relative 'student_base.rb'
require_relative 'module.rb'

class Student < StudentBase
  include Comparable
  extend ValidatedAttributes
  attr_reader :last_name, :first_name, :patronymic

  NAME_REGEX= /\A[A-ZА-Я]{1}[a-zа-яё]+\z/
  PHONE_REGEX= /^(\+7|8)?[\s\-\(]?(\d{3})[\s\-\)]?(\d{3})[\s\-]?(\d{2})[\s\-]?(\d{2})$/
  TELEGRAM_REGEX= /\A@[a-zA-Z0-9_]{5,32}\z/
  EMAIL_REGEX= /\A[\w+\-.\+]+@[a-z\d\-]+(\.[a-z]+)+\z/i
  GIT_REGEX= %r{\Ahttps://git(hub)?(lab)?\.com/[a-zA-Z0-9_-]{1,39}(/[a-zA-Z0-9_-]{1,100})?/?\z}
    
  attr_validate_writer :last_name, field_name: "last_name", required: true, with: :valid_name?
  attr_validate_writer :first_name, field_name: "first_name", required: true, with: :valid_name?
  attr_validate_writer :patronymic, field_name: "patronymic", required: false, with: :valid_name?
  attr_validate_writer :git, field_name: "git", required: false, with: :valid_git?
  attr_validate_writer :phone, field_name: "phone", required: false, with: :valid_phone?
  attr_validate_writer :telegram, field_name: "telegram", required: false, with: :valid_telegram?
  attr_validate_writer :email, field_name: "email", required: false, with: :valid_email?

  def initialize(last_name:, first_name:, id: nil, patronymic: nil, phone: nil, telegram: nil, email: nil, git: nil)
    raise ArgumentError, "Incorrect git entry" if !git.nil? && !self.class.valid_git?(git)
    super(id: id, git: git)
    self.last_name = last_name
    self.first_name = first_name
    self.patronymic = patronymic

    set_contact_values(phone: phone, telegram: telegram, email: email)
  end

  def contact=(contacts)
		raise ArgumentError, "Expected Hash, given #{contacts.class}" unless contacts.is_a?(Hash)
    raise ArgumentError, "Expected 3 contacts, given #{contacts.length}" if contacts.length != 3 

    valid_keys = [:phone, :telegram, :email]
    invalid_keys = contacts.keys - valid_keys
        
    raise ArgumentError, "Unknown type of contact #{invalid_keys.first}" if !invalid_keys.empty?
        
    set_contact_values(phone: contacts[:phone], telegram: contacts[:telegram], email: contacts[:email])
  end

  def contact=(contacts)
		raise ArgumentError, "Expected Hash, given #{contacts.class}" unless contacts.is_a?(Hash)
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

  def last_name_initials
		"#{@last_name} #{@first_name[0]}." if patronymic.nil?
    
		"#{@last_name} #{@first_name[0]}. #{@patronymic[0]}."
  end

  def <=>(other)
    if other.nil? or other.class != Student
      raise ArgumentException, "Could not compare ArrayProcessor with #{nil ? other.nil? : other.class}"
    end
    self.last_name <=> other.last_name
  end	

  def to_s
    result = "#{id}" 
    result += "\nfio - #{last_name} #{first_name} #{patronymic  'нет'} "
    result += "\nphone - #{@phone}" if @phone && !@phone.empty?
    result += "\ntelegram - #{@telegram}" if @telegram && !@telegram.empty?
    result += "\nemail - #{@email}" if @email && !@email.empty?
    result += "git - #{git}" if has_git?
  end


  def self.valid_name? (value)
		self.validate_field(value){|elem| elem.match?(NAME_REGEX)}
  end
	
	def self.valid_phone? (value)
		self.validate_field(value){|elem| elem.match?(PHONE_REGEX)}
	end		
	
	def self.valid_telegram? (value)
		self.validate_field(value){|elem| elem.match?(TELEGRAM_REGEX)}
	end

	def self.valid_email? (value)
		self.validate_field(value){|elem| elem.match?(EMAIL_REGEX)}
	end

	def self.valid_git? (value)
		self.validate_field(value){|elem| elem.match?(GIT_REGEX)}
	end
   

  private 
  
  def self.validate_field(value)
    return true if value.nil? or value.empty?
    yield(value)
  end

  def get_main_contact
    [
      { type: 'telegram', value: @telegram },
      { type: 'email', value: @email },
      { type: 'phone', value: @phone }
    ].find { |contact| contact[:value] && !contact[:value].empty? }
  end  

  def set_contact_values(phone:, telegram:, email:)
    self.phone = phone
    self.telegram = telegram
    self.email = email
  end

end
