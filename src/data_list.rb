class DataList
    def initialize(array)
        replace(array)
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
        attributes = attributes_info.dup
        return attributes
    end

    def get_data
        data=[]

        @elements.each_with_index do |elem, index|
            row = [index + 1]
            row.concat(fields_info(elem))
            data<<row          
        end

        create_data_table data
  
    end

    def clear_selected
        @selected.clear
    end

    def replace (array)
        @elements = array.dup
    end

    private

    def validate_index(index)
        if index < 0 || index >= @elements.length
            raise IndexError, "Incorrect index: #{index}"
        end
    end

    private
    
    def fields_info student
      raise NotImplementedError, "Method must be implemented in child class"
    end

    def create_data_table data
      raise NotImplementedError, "Method must be implemented in child class"
    end    
    
    def attributes_info
        raise NotImplementedError, "Method must be implemented in child class"
    end


end