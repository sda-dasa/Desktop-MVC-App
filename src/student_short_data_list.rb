require_relative 'data_table.rb'
require_relative 'data_list.rb'

class DataListStudentShort < DataList
    def get_names
        ["№ по порядку", "ФИО", "Контакт", "Git"]
    end
    def student_info student
        [student.last_name_initials, student.contact || 'нет', 
        student.git || 'нет']
    end

    def create_data_table
        DataTable.new(data)
    end

end