require_relative "../db/config/SQLiteDB"
require_relative "Student_list_DB"
require_relative "../exceptions/UniqueViolation"

class Student_list_DB_2 < Student_list_DB
    
  def initialize
    @conn=SQLiteDB.instance
    super('sqlite_application.log')    
  end  

  private 
  def update(id, student_hash) 
    request = ""
    request += "last_name = #{student_hash[:last_name]} " if student_hash[:last_name]
    request += "first_name = #{student_hash[:first_name]} " if student_hash[:first_name]
    request += "patronymic = #{student_hash[:patronymic]} " if student_hash[:patronymic]
    request += "phone = #{student_hash[:phone]} " if student_hash[:phone]
    request += "email = #{student_hash[:email]} " if student_hash[:email]
    request += "git = #{student_hash[:git]} " if student_hash[:git]
    request += "where id = #{id}"
    sql_req = "update student set " + request.split().join(', ') + "where id = #{id}"
    begin
      @conn.execute(sql_req)
    rescue SQLite3::ConstraintException
      raise UniqueViolation, "Duplicate key value violates uniqueness constraint"
    end
  end

  def delete(id)
    @conn.execute_params("DELETE FROM student WHERE id = ?", [id])
  end

  def insert (student_hash)
    begin
      @conn.execute_params(
        "INSERT INTO student (id, first_name, last_name, patronymic, phone, email, telegram, git) VALUES (?,?,?,?,?,?,?,?)",
        [student_hash[:id], student_hash[:first_name], student_hash[:last_name], student_hash[:patronymic], 
        student_hash[:phone], student_hash[:email],student_hash[:telegram], student_hash[:git]],
      )
    rescue SQLite3::ConstraintException
      raise UniqueViolation, "Duplicate key value violates uniqueness constraint"
    end
  end

  def get_data_k_n(k, n)
    @conn.execute("SELECT * FROM student WHERE ID = #{k*n + 1} ORDER BY id LIMIT #{n};")
  end

  def amount_of_rows
    @conn.execute("SELECT COUNT(*) FROM student")
  end

  def max_id
    @conn.execute("SELECT ID FROM student ORDER BY ID DESC LIMIT 1")
  end 

end










exemp = Student_list_DB_2.new
puts exemp.get_count


# hash1= {id: 1,  first_name: 'Иван', last_name: 'Петров', email: 'ivan.petrov@example.com'}
# hash2 = { id: 4, first_name: 'Елена', last_name: 'Петрова', email: 'elena.kuznetsova@example.com', git: nil}
# exemp.update_by_id(1, hash1)
# exemp.delete_by_id(11)
# exemp.insert(hash2)
# exemp.get_count
# i = 1
# while i < 9
#     puts exemp.get_by_id(i)
#     i+=1
# end