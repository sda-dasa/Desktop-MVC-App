class DataList
    def initialize(elements)
        @elements = elements
        @selected = []
    end

    def select(number)
        validate_index(number)
        @selected << number unless @selected.include?(number)
    end

    def get_selected
        @selected.map { |index| @elements[index].id }.dup
    end

    def get_names
        raise NotImplementedError, "Method get_names must be implemented in child class"
    end

    def get_data
      data = []
        
      @elements.each_with_index do |student, index|
        row = [
          index + 1,
          student.last_name_initials,
          student.contact || "нет",
          student.git || "нет"
      ]
      data << row
      end
    end

    def student_info student
      raise NotImplementedError, "Method student_info must be implemented in child class"
    end

    def create_data_table data
      raise NotImplementedError, "Method student_info must be implemented in child class"
    end

    def clear_selected
        @selected.clear
    end

    private

    def validate_index(index)
        if index < 0 || index >= @elements.length
            raise IndexError, "Некорректный индекс: #{index}"
        end
    end
end