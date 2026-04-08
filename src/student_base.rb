class StudentBase
    attr_reader :id, :git
    
    def initialize(id: nil, git: nil)
        @id = id
        @git = git
    end

    def to_s
        raise NotImplementedError, "Method to_s must be implemented in child class"
    end

    def contact
        raise NotImplementedError, "Method contact must be implemented in child class"
    end

    def last_name_initials
        raise NotImplementedError, "Method last_name_initials must be implemented in child class"
    end

    def has_contact?
        !contact.nil?
    end

    def has_git?
        !git.nil?
    end

    def short_info
        info = "id - #{id}, fio - #{last_name_initials}"
        info += ", contact - #{contact}" if has_contact?
        info += ", git - #{git}" if has_git?
        info
    end

end