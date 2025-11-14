require_relative 'data_table.rb'
require_relative 'data_list.rb'

class DataListStudentShort < DataList
    def get_names
        ["№ по порядку", "ФИО", "Контакт", "Git"]
    end
    
    def get_data 
        data = []

        @elements.each_with_index do |student, index|
            row = [
                index + 1,
                student.last_name_initials,
                student.contact || "none",
                student.git || "none"
            ]       
            data << row
        end
        DataTable.new data
    end

end