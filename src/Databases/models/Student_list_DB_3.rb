require_relative "../db/config/MongoDB"
require_relative "Student_list_DB"
require_relative "../exceptions/UniqueViolation"

class Student_list_DB_3 < Student_list_DB
    COLLECTION_NAME = :student
  def initialize
    @conn=MGDB.instance.connect[COLLECTION_NAME]
    super('mongo_application.log')   
  end

  private
  def update(id, student_hash)
    begin
      @conn.update_one(
        {id: id},
        { '$set' => student_hash }
      )
    rescue Mongo::Error::OperationFailure => e
      if e.message =~ /E11000/
        raise UniqueViolation, "Duplicate key value violates uniqueness constraint"
      else 
        raise Mongo::Error, "Operation failed: #{e.message}"
      end
    end
  end

  def delete(id)
    @conn.delete_one(id: id)  
  end

  def insert(student_hash)
    begin
      @conn.insert_one(student_hash)
    rescue Mongo::Error::OperationFailure
      if e.message =~ /E11000/
        raise UniqueViolation, "Duplicate key value violates uniqueness constraint"
      else 
        raise Mongo::Error, "Operation failed: #{e.message}"
      end
    end
  end

  def get_data_k_n(k , n)
    start_id = k * n + 1
    end_id = start_id + n - 1
    return @conn.find({'id' => { '$gte' => start_id, '$lte' => end_id }}, projection: {'_id' => 0}).to_a
  end

  def amount_of_rows
    @conn.count
  end

  def max_id
    @conn.find().sort({id: -1}).limit(1)
  end

end




# [11000]: E11000 duplicate key error collection: Students.student index: id_1 dup key: { id: 10 } (on localhost:27017, legacy retry, attempt 1) (Mongo::Error::OperationFailure)




db = Student_list_DB_3.new
puts db.get_count
# db.insert({id: 9, first_name: 'Арина', last_name: 'Светлова', email: 'elena.svetlova@example.com'})
# puts db.get_by_id(-1)
# puts db.get_k_n_student_short_list(2,2).get_data.get_element(1,0)
db.update_by_id(4,{last_name: 'Алексей'})
puts db.get_k_n_student_short_list(1,10).get_data.get_element(3,1)
# db.insert({id: 10, first_name: 'Светлана', last_name: 'Анохина', email: 'svetlana.anohina@example.com'})
puts db.get_k_n_student_short_list(3,6).get_data.get_element(0,0)