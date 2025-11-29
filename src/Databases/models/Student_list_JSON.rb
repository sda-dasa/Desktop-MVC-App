# = StudentsListJSON
#
# Класс для работы со списком студентов в формате JSON.
# Наследует от StudentsListBase и реализует методы чтения/записи JSON файлов.
#
# == Пример использования:
#
#   list = StudentsListJSON.new('students.json')
#   list.add_student(student)
#   list.write_all
#
# == Формат файла:
#
#   [
#     {
#       "id": 1,
#       "first_name": "Иван",
#       "last_name": "Петров",
#       "patronymic": "Иванович",
#       "email": "ivan@example.com",
#       "phone": "+79991234567"
#     }
#   ]
#
#
require_relative 'Student_list_Base'

class StudentsListJSON < StudentsListBase

  # Создает новый объект StudentsListJSON
  #
  # @param filename [String] путь к JSON файлу
  #
  def initialize(filename)
    super
  end

  # Чтение данных из JSON файла
  #
  # @return [Array<Student>] массив объектов Student
  # @raise [JSON::ParserError] если файл содержит некорректный JSON
  #  
  protected

  def read_file
    return [] unless File.exist?(@filename)
    
    json_data = File.read(@filename)
    return [] if json_data.strip.empty?
    
    data = JSON.parse(json_data, symbolize_names: true)
    return data
  end


  # Запись данных в JSON файл
  #
  # @param data [Array<Student>] массив объектов Student для записи
  # @return [void]
  #
  def write_file(data)
    student_hashes = data.map(&:to_h)
    File.write(@filename, JSON.pretty_generate(student_hashes))
  end
end




