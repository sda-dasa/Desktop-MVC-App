class AppLogger
  @@instance = nil

  def self.instance (log_file = 'pg_application.log', level = :info)
    @@instance ||= new(log_file, level)
  end

  private_class_method :new
  
  def initialize (log_file, level)
    @log_file = "..\\logs\\#{log_file}"
    @level = level
  end

  def level=(new_level)
    if LOG_LEVELS.key?(new_level.to_sym)
      @level = new_level.to_sym
    else
      warn "Unknown log level: #{new_level}. Using current level: #{@level}"
    end
  end

  def level
    @level
  end

  LOG_LEVELS = {
    info: 1,
    warn: 2,
    error: 3
  }.freeze

  def info(message)
    write(:info, message) if should_log?(:info)
  end  

  def warn(message)
    write(:warn, message) if should_log?(:warn)
  end

  def error(message)
    write(:error, message) if should_log?(:error)
  end

  private 

  def should_log?(message_level)
    LOG_LEVELS[message_level] >= LOG_LEVELS[@level]
  end

  def write(level, message)
    timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    formatted_message = "[#{timestamp}] #{level.to_s.upcase}: #{message}\n"
    
    begin 
      File.open(@log_file, 'a') do |file|
        file.write(formatted_message)
      end
    rescue => e
      puts "Failed to write to log file: #{e.message}"
    end 
  end



end
