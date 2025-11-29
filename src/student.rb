require_relative 'student_base.rb'
require_relative 'module.rb'

class Student < StudentBase
  # include Comparable
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
    
  # public 
  # {
  #   name: NAME_REGEX,
  #   phone: PHONE_REGEX,
  #   telegram: TELEGRAM_REGEX,
  #   email: EMAIL_REGEX,
  #   git: GIT_REGEX
  # }.each do |field_name, regex| 
  #     attr_validate field_name, regex: regex
  # end
  attr_validate :name, regex: NAME_REGEX
  attr_validate :phone, regex: PHONE_REGEX
  attr_validate :telegram, regex: TELEGRAM_REGEX
  attr_validate :email, regex: EMAIL_REGEX
  attr_validate :git, regex: GIT_REGEX

  def initialize(last_name:, first_name:, id: nil, patronymic: nil, phone: nil, telegram: nil, email: nil, git: nil)
    raise ArgumentError, "Incorrect git entry" unless git.nil? or self.class.valid_git?(git)
    super(id: id.to_i, git: git)
    self.last_name= last_name
    self.first_name= first_name
    self.patronymic= patronymic
    self.contact= {phone: phone, telegram: telegram, email: email}
  end


  # def self.init_with_hash(student)
  #   raise ArgumentError, "Expected Hash, given #{student.class}" unless student.is_a?(Hash)
  #   raise ArgumentError, "Expected at least 2 keys, given #{student.length}" unless student.length >= 2

  #   normalized = Hash[student.map{ |k, v| [k.to_sym, v] }]

  #   valid_keys = [:last_name, :first_name, :patronymic, :phone, :telegram, :email, :git, :id]
  #   invalid_keys = normalized.keys - valid_keys    
        
  #   raise ArgumentError, "Unknown type of attribute #{invalid_keys.first}" unless invalid_keys.empty? 

  #   normalized_hash = {
  #     last_name: normalized[:last_name],
  #     first_name: normalized[:first_name],
  #     id: normalized[:id].to_i,
  #     patronymic: normalized[:patronymic],
  #     phone: normalized[:phone],
  #     telegram: normalized[:telegram],
  #     email: normalized[:email],
  #     git: normalized[:git]
  #   } 
  #   new(**normalized_hash)

  # end

  def contact=(contacts)
		raise ArgumentError, "Expected Hash, given #{contacts.class}" unless contacts.is_a?(Hash)
    raise ArgumentError, "Expected 3 contacts, given #{contacts.length}" if contacts.length != 3 

    valid_keys = [:phone, :telegram, :email]
    invalid_keys = contacts.keys - valid_keys
        
    raise ArgumentError, "Unknown type of contact #{invalid_keys.first}" if !invalid_keys.empty?
        
    self.phone = contacts[:phone]
    self.telegram = contacts[:telegram]
    self.email = contacts[:email]
  end  

  def contact
    existing_contact=[
      { type: 'telegram', value: @telegram },
      { type: 'email', value: @email },
      { type: 'phone', value: @phone }
    ].find { |contact| contact[:value] && !contact[:value].empty? }

    return nil unless existing_contact
    "#{existing_contact[:type]} - #{existing_contact[:value]}"
  end 

  def last_name_initials		
    if patronymic.nil?
      return "#{@last_name} #{@first_name[0]}."
    end
    return "#{@last_name} #{@first_name[0]}. #{@patronymic[0]}."
  end

  # def <=>(other)
  #   if other.nil? or other.class != Student
  #     raise ArgumentError, "Could not compare Student with #{nil ? other.nil? : other.class}"
  #   end
  #   self.last_name <=> other.last_name
  # end	

  def to_s
    result = "#{id}" 
    result += "\nfio - #{last_name} #{first_name} #{patronymic || 'нет'} "
    result += "\nphone - #{@phone}" if @phone && !@phone.empty?
    result += "\ntelegram - #{@telegram}" if @telegram && !@telegram.empty?
    result += "\nemail - #{@email}" if @email && !@email.empty?
    result += "git - #{git}" if has_git?
    return result
  end

  # def to_h
  #   {id: @id, last_name: last_name, first_name: first_name, patronymic: patronymic, phone: @phone, email: @email, telegram: @telegram, git: git}
  # end
  # 
  # private
  # attr_validate_writer :phone, field_name: "phone", required: false, with: :valid_phone?
  # attr_validate_writer :telegram, field_name: "telegram", required: false, with: :valid_telegram?
  # attr_validate_writer :email, field_name: "email", required: false, with: :valid_email?


end
