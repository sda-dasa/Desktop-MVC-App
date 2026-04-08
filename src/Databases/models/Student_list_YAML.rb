require_relative 'Student_list_Base'

class StudentsListYAML < StudentsListBase
  protected

  def read_file
    return [] unless File.exist?(@filename)
    
    yaml_data = File.read(@filename)
    return [] if yaml_data.strip.empty?
    
    data = YAML.safe_load(yaml_data, permitted_classes: [Symbol], symbolize_names: true)
    return data
  end
  def write_file(data)
    student_hashes = data.map(&:to_h)
    File.write(@filename, student_hashes.to_yaml)
  end
end


