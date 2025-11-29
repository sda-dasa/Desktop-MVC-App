module ValidatedAttributes
  def attr_validate_writer(attribute, field_name: String?, required: Boolean, with: Block)
    define_method("#{attribute}=") do |value|
      if required && (value.nil? || value.to_s.empty?)
        raise ArgumentError, "#{field_name} is required"
      end
      if with && value && !self.class.send(with, value)
        raise ArgumentError, "#{field_name} is invalid"
      end
      instance_variable_set("@#{attribute}", value)
    end
  end

  def attr_validate (attribute, regex:)
    define_singleton_method("valid_#{attribute}?") do |value|
      return value.match?(regex)
    end    
  end

end