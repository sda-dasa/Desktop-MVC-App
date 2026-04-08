require_relative 'student.rb'
require_relative 'student_base.rb'

class StudentShort < StudentBase
  attr_reader :last_name_initials, :contact
  
  def initialize(id:, last_name_initials:, contact: nil, git: nil)
    super(id: id, git: git)
    @last_name_initials = last_name_initials
    @contact = contact
  end

  def self.from_student(student)
    raise ArgumentError, "Expected Student, given #{student.class}" unless student.is_a?(Student)

    new( id: student.id, last_name_initials: student.last_name_initials, contact: student.contact, git: student.git)
  end
  
  
  def to_s
    "
      id - #{id}
      fio - #{last_name_initials} 
      contact - #{contact}
      git - #{git} 
    "
  end

end