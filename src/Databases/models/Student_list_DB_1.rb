require_relative "../db/config/PostgreSQLDB"
require_relative "Student_list_DB"
require_relative "../exceptions/UniqueViolation"

class Student_list_DB_1 < Student_list_DB
    
  def initialize
    @conn=PGDB.instance
    super('pg_aplication.log')   
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
    rescue PG::UniqueViolation
      raise UniqueViolation, "Duplicate key value violates uniqueness constraint"
    end
  end

  def delete(id)
    @conn.execute_params("DELETE FROM student WHERE id = ($1)", [id])
  end

  def insert (student_hash)
    begin     
      @conn.execute_params(
        "INSERT INTO student (id, first_name, last_name, patronymic, phone, email, telegram, git) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)",
        [student_hash[:id], student_hash[:first_name], student_hash[:last_name], student_hash[:patronymic], 
        student_hash[:phone], student_hash[:email],student_hash[:telegram], student_hash[:git]],
      )
    rescue PG::UniqueViolation
      raise UniqueViolation, "Duplicate key value violates uniqueness constraint"
    end 
  end

  def get_data_k_n(k , n)
    @conn.execute("SELECT * FROM student WHERE ID = #{k*n + 1} ORDER BY id LIMIT #{n};")   
  end

  def amount_of_rows
    @conn.execute("SELECT COUNT(*) FROM student")
  end

  def max_id
    @conn.execute("SELECT ID FROM student ORDER BY ID DESC LIMIT 1")
  end

end




exemp = Student_list_DB_1.new
puts exemp.get_count
puts exemp.get_by_id(1)
hash = {first_name: "Иван", last_name: "Иванович"}
exemp.insert(hash)

puts exemp.get_by_id(12)

