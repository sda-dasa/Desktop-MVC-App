class StudentShort
	def initialize (id: , last_name_initials: , contact: , git: )
		@id = id
		@last_name_initials  = last_name_initials
		@contact = contact
		@git = git
	end

	attr_reader :id, :last_name_initials, :contact, :git

	def self.from_student (student)	
		new (student.id, student.last_name_initials, student.contact, student.git)
	end

	def short_info
		if !@id.nil?
		return "id - #{@id} last_name_initials - #{@last_name_initials} contact - #{@contact} git - #{@git}"
		else 
		return "last_name_initials - #{@last_name_initials} contact - #{@contact} git - #{@git}"
		end
	end

	def to_s
		return "id - #{@id} last_name_initials - #{@last_name_initials} contact - #{@contact} git - #{@git}"
	end

	def has_git?
		not (git.nil? or git.empty?)
	end

	def has_contact?
		not (contact.nil? or contact.empty?)
	end



end