
class DataTable
  def initialize(data)
    validate_data(data)
    @data = data.dup
  end

  def get_element(row, col)
    validate_indices(row, col)
    safe_return(@data[row][col])
  end

  def columns_count
    return 0 if @data.empty?
    @data.map{|element| element.length}.max
  end

  def rows_count
    @data.length
  end

  private

  def validate_data(data)
    unless data.is_a?(Array) && data.all? { |row| row.is_a?(Array) }
    raise ArgumentError, "Data must be two-dimensional array"
    end
    widths = data.map{|element| element.length}.uniq
    return if widths.length <= 1
    raise ArgumentError, "All rows must have the same amount of attributes"
  end

  def validate_indices(row, col)
    if row < 0  or row >= rows_count
      raise IndexError, " row index: #{row}"
    end
    if col < 0  or col >= @data[row].length
        raise IndexError, "Incorrect cloumn index #{col}"
    end
  end

 
end