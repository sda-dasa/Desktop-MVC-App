class StudentShort
	def initialize (id: , last_name_initials: , contact: nil, git: nil)
		@id = id
		@last_name_initials  = last_name_initials
		@contact = contact
		@git = git
	end

	attr_reader :id, :last_name_initials, :contact, :git

	def self.from_student (student)	
    	raise ArgumentError, "Expected Student, given #{student.class}" unless student.is_a?(Student)
		new(id: student.id, last_name_initials: student.last_name_initials, contact: student.contact, git: student.git)
	end

	def short_info
		student_info(show_all: false)
	end

	def to_s
		student_info(show_all: true)
	end


  def student_info(show_all:)
    result = []
    result << "id - #{id}" if show_all || id
    result << "last_name_initials - #{last_name_initials}"

    result << "contact - #{contact}" if show_all || has_contact?

    result << "git - #{git}" if show_all || has_git?
    result.join("\n")

  end

	def has_git?
		not (git.nil? or git.empty?)
	end

	def has_contact?
		not (contact.nil? or contact.empty?)
	end


end
