require 'dotenv'

Dotenv.load
require 'mongo'

class MGDB
  @@instance = nil
  
  def self.instance ()
    @@instance ||= new
  end

  private_class_method :new

  def initialize (host: 'localhost:27017', dbname: 'Students')
    @host = host 
    @dbname = dbname
  end 


  def connect
    begin
      @client ||= Mongo::Client.new(
        [@host],
        database: @dbname
      )
      @client
    rescue Mongo::Error => e
      puts "DB connection error #{e.message}"
      exit
    end
  end
  

end

