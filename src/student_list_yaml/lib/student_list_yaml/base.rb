require 'json'
require 'yaml'
require'data_list'
require'student'
require'student_short'


class StudentsListBase
  def initialize(filename)
    @filename = filename
    @list = []
    read_all
  end

  protected

  def read_file
    raise NotImplementedError, "Subclass must implement read_file"
  end
  def write_file(data)
    raise NotImplementedError, "Subclass must implement write_file"
  end

  public
  def read_all
    @list = read_file.map { |student_data| Student.init_with_hash(student_data) }
  end

  def write_all
    write_file(@list)    
  end

  def get_by_id(id)
    @list.find { |student| student.id == id }
  end


  def get_k_n_student_short_list(k, n, existing_list = nil)

    raise ArgumentError, "Expected class Integer, given #{k.class}" unless k.is_a?(Integer)
    raise ArgumentError, "Expected class Integer, given #{n.class}" unless n.is_a?(Integer)
    raise ArgumentError, "Expected k to be greater than 0" unless k > 0
    raise ArgumentError, "Expected n to be greater than 0" unless n > 0
    raise ArgumentError, "Expected class DataList, given #{existing_list.class}" if existing_list and !existing_list.is_a?(DataList)
    start_index = (k-1) * n + 1
    end_index = start_index + n
    
    slice = @list[start_index..end_index] || []
    student_shorts = slice.map { |student| StudentShort.from_student(student) }
    
    existing_list ? existing_list.replace(student_shorts) : DataList.new(student_shorts)
  end

  def sort_by_name
    @list = @list.sort_by{ |student| student.last_name_initials }
  end

  def insert(student_hash)
    new_id = @list.empty? ? 1 : @list.map(&:id).max + 1
    student_hash[:id] = new_id
    @list << Student.init_with_hash(student_hash)
    return true
  end

  def update_by_id(id, student_hash)
    index = @list.find_index { |student| student.id == id }
    return false unless index
    
    student_hash[:id] = id
    @list[index] = Student.init_with_hash(student_hash)
    true
  end

  def delete_by_id(id)
    curr_size = @list.size
    @list.delete(get_by_id(id))
    return get_student_short_count < curr_size
  end

  def get_student_short_count
    @list.size
  end

end