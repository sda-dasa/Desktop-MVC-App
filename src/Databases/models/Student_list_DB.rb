require_relative "../../student"
require_relative "../../student_short"
require_relative "../../data_list"
require_relative "../utils/logger"

class Student_list_DB
    
  def initialize(log_file, level)
    @logger = AppLogger.instance(log_file, level)
    @list = upload
    @logger.info("Student list loaded with #{@list.length} students")
  end  

  def get_by_id (id)
    @logger.info("Getting student by id: #{id}")
    raise ArgumentError, "Expected class Fixnum, given #{id.class}" unless id.is_a?(Integer)
    raise ArgumentError, "Expected id to be greater than 0" unless id > 0
    begin 
      if id >= (@range[:k]-1)*@range[:n] + 1 and id <= @range[:k]*@range[:n]
        result = @list.find{|student| student.id == id}
      else 
        result = Student.init_with_hash(upload(id, 1).first)
      end
      if result
        @logger.info("Student found with id: #{id}")
        return result    
      else
        @logger.warn("Student not found with id: #{id}")
        false
      end 
    rescue => e
      @logger.error("Failed to get student by id, id: #{id} error: #{e.message}")
    end
    
  end

  def get_student_short_count   
    @logger.info("Getting student count")
    begin
      count = amount_of_rows
      @logger.info("Count gotten: #{count}")
      return count
    rescue => e
      @logger.error("Failed to get count, error: #{e.message}")
    end
  end

  def update_by_id (id, student_hash)
    @logger.info("Updating student with id: #{id}, data: #{student_hash}")
    begin
      if update(id, student_hash)
        @logger.info("Student updated in database, id: #{id}")
        if get_by_id(id) and id >= (@range[:k]-1)*@range[:n] + 1 and id <= @range[:k]*@range[:n]
          @list[@list.find_index{|student| student.id == id}] = Student.init_with_hash(upload(id,1).first)
        end
        true
      else
        @logger.warn("Student not updated in database, id: #{id}")
        false
      end
    rescue => e
      @logger.error("Failed to update student in database, id: #{id}, error: #{e.message}")
      false
    end
  end

  def delete_by_id(id)

    @logger.info("Deleting student with id: #{id}")  

    if get_by_id(id) and id >= (@range[:k]-1)*@range[:n] + 1 and id <= @range[:k]*@range[:n]
      @list.delete(get_by_id(id))

      @logger.info("Student deleted from memory list, id: #{id}")

    else
      @logger.warn("Student not found in memory list for deletion, id: #{id}")
    end
    begin
      if delete(id)   
        @logger.info("Student deleted from database, id: #{id}")
        true
      else
        @logger.warn("Student deleted from database, id: #{id}")
        false
      end
    rescue => e
      @logger.error("Failed to delete student from database, id: #{id}, error: #{e.message}")
      false
    end
  end

  def insert_into(student_hash)
    @logger.info("Inserting new student with data: #{student_hash}")
    student_hash[:id] = max_id + 1 
    begin
       if insert(student_hash)
        @logger.info("Student inserted into database with id: #{student_hash[:id]}")
        if max_id >= (@range[:k]-1)*@range[:n] + 1 and max_id <= @range[:k]*@range[:n] - 1
          @list[max_id] = Student.init_with_hash(student_hash)
          @logger.info("Student added to memory list")
        end
        true   
       else
        @logger.warn("Student not inserted into database with id: #{student_hash[:id]}")
        false
       end
    rescue => e
      @logger.error("Failed to insert student into database, error: #{e.message}")
      raise e
    end
    
  end

  def get_k_n_student_short_list (k, n)

    @logger.info("Getting student short list, k: #{k}, n: #{n}")

    raise ArgumentError, "Expected class Integer, given #{k.class}" unless k.is_a?(Integer)
    raise ArgumentError, "Expected class Integer, given #{n.class}" unless n.is_a?(Integer)
    raise ArgumentError, "Expected k to be greater than 0" unless k > 0
    raise ArgumentError, "Expected n to be greater than 0" unless n > 0
    
    # @logger.error("Indexes k=#{k}, n=#{n} out of range")
    # raise IndexError, "Indexes out of range" unless n*k <= get_student_short_count

    @logger.info("Returning student short list")
    @list = upload(k,n) || []
    DataList.new(@list.map{|student| StudentShort.from_student(student)})

  end

  private
  def upload(k=1 , n=10)
    logger = AppLogger.instance
    logger.info("Uploading all students from database")
    begin
      result = get_data_k_n(k-1, n)
      array = []
      result.each do |row|
        array.append(Student.init_with_hash(row))
      end
      logger.info("Successfully uploaded #{array.length} students from database")
      @range = {k:k, n:n}
      return array
    rescue => e
      logger.error("Failed to upload students from database: #{e.message}")
      raise
    end
  end

  def get_data_k_n(k , n)
    raise NotImplementedError, "Method must be implemented in child class"
  end

  def insert(student_hash)
    raise NotImplementedError, "Method must be implemented in child class"
  end

  def delete(id)
    raise NotImplementedError, "Method must be implemented in child class"
  end

  def update(id, student_hash)
    raise NotImplementedError, "Method must be implemented in child class"
  end

  def amount_of_rows
    raise NotImplementedError, "Method must be implemented in child class"
  end

  def max_id
    raise NotImplementedError, "Method must be implemented in child class"
  end
  
end

