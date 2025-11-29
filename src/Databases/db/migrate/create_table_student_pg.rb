require_relative '../../db/config/PostgreSQLDB'

def create_student_table_pg
  conn = PGDB.instance

  begin 
    conn.execute("
      drop table student;
      CREATE TABLE student (
        id INTEGER PRIMARY KEY,
        first_name VARCHAR(150) NOT NULL,
        last_name VARCHAR(150) NOT NULL,
        patronymic VARCHAR (150),
        phone VARCHAR(20) UNIQUE, 
        email VARCHAR(100) UNIQUE,
        telegram VARCHAR(100) UNIQUE,
        git VARCHAR(300) UNIQUE
      );
    ")
  rescue PG::Error => e
    puts "Table \'Student\' creation error #{e.message}"
  end
  
end


create_student_table_pg