require_relative 'data_table.rb'
require_relative 'data_list.rb'
require_relative 'student_short.rb'

class DataListStudentShort < DataList

    def initialize(array)
        super(array) if array.all?{elem.class==StudentShort} 
        raise ArgumentError, "Expected StudentShort exemplars in array" 
    end

    private 
    def attributes_info
        ["№ по порядку", "ФИО", "Контакт", "Git"]
    end
    
    def fields_info student
        [student.last_name_initials, student.contact || 'нет', 
        student.git || 'нет']
    end

    def create_data_table data
        DataTable.new(data)
    end    
end