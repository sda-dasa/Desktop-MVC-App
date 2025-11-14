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
        raise NotImplementedError, "Method must be implemented in child class"
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