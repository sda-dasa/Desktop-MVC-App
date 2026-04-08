require_relative '../../db/config/SQLiteDB'

def create_student_table_sqlite
  conn = SQLiteDB.instance.connect

  begin 
    conn.execute("
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
  rescue SQLite3::Exception => e
    puts "Table \'Student\' creation error #{e.message}"
  ensure
    conn.close if conn
  end
  
end


create_student_table_sqlite