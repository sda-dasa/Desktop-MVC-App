class UniqueViolation < StandartError
  def initialize(message=nil)
    super(message || default_message)
  end

  def default_message
    "Unique constraint violation"
  end

end