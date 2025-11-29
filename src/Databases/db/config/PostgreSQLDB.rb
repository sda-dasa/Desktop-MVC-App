require 'dotenv'

Dotenv.load
require 'pg'
require_relative 'DBConnectionError'

class PGDB
  @@instance = nil
  
  def self.instance ()
    @@instance ||= new
  end

  private_class_method :new

  def initialize (host: 'localhost', port: 5432 , dbname: 'Students', user:'postgres')
    @host = host 
    @port = port
    @dbname = dbname
    @user = user
    @password = ENV['DB_PSWD']
  end 

  def execute_params(sql, value)
    conn = connect
    result = conn.exec_params(sql, value)
    conn.close
    return result.cmd_tuples > 0
  end

  def execute(sql)
    conn = connect
    result = conn.exec(sql)
    conn.close
    return result 
  end

  def connect
    begin
      PG.connect(host: @host, port: @port, dbname: @dbname, user: @user, password: @password)
    rescue PG::Error => e
      raise DBConnectionError, "#{e.message} \n #{e.backtrace.join("\n")}"
      exit
    end
  end

end

