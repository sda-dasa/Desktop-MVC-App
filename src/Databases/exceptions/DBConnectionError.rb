class DBConnectionError < StandartError
  def initialize(message=nil)
    super(message || default_message)
  end

  def default_message
    "DB connection error"
  end

end