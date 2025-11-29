require 'dotenv'

Dotenv.load

require 'sqlite3'
require_relative 'DBConnectionError'

class SQLiteDB
  @@instance = nil
  
  def self.instance
    @@instance ||= new
  end

  private_class_method :new

  def initialize(db_path: '..\student.db')
    @db_path = db_path
  end
  
  def connect
    begin
      SQLite3::Database.new(@db_path)
    rescue SQLite3::Exception => e
      raise DBConnectionError, "#{e.message} \n #{e.backtrace.join("\n")}"
      exit
    end
  end

  def execute_params(sql, values)
    conn = connect
    conn.execute(sql, values)
    changes = conn.changes > 0
    conn.close
    return changes
  end

  def execute(sql)
    conn = connect
    conn.results_as_hash = true
    result = conn.execute(sql)
    conn.close
    return result
  end

end