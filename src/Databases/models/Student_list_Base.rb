require 'json'
require 'yaml'
require_relative '../../data_list'
require_relative '../../student'
require_relative '../../student_short'

# = StudentsListBase
#
# Абстрактный базовый класс для работы со списками студентов в различных форматах файлов.
# Определяет общий интерфейс и базовую функциональность для управления списком студентов.
#
# == Подклассы:
# * StudentsListJSON - для работы с JSON файлами
# * StudentsListYAML - для работы с YAML файлами
#
# @abstract Подклассы должны реализовать методы {#read_file} и {#write_file}
#
class StudentsListBase

  # Инициализирует новый объект списка студентов
  #
  # @param filename [String] путь к файлу с данными студентов
  # @raise [Errno::ENOENT] если файл не существует (зависит от реализации read_file)
  #
  # @example Создание объекта списка студентов
  #   list = StudentsListJSON.new("students.json")
  #   list = StudentsListYAML.new("students.yaml")
  #
  def initialize(filename)
    @filename = filename
    @list = []
    read_all
  end

  protected

  # Чтение данных из файла (абстрактный метод)
  #
  # @abstract Подклассы должны реализовать этот метод
  # @return [Array<Hash>] массив хэшей с данными студентов
  # @raise [NotImplementedError] если метод не реализован в подклассе
  #
  def read_file
    raise NotImplementedError, "Subclass must implement read_file"
  end

  # Запись данных в файл (абстрактный метод)
  #
  # @abstract Подклассы должны реализовать этот метод
  # @param data [Array<Student>] массив объектов Student для записи
  # @return [void]
  # @raise [NotImplementedError] если метод не реализован в подклассе
  # @raise [Errno::EACCES] если нет прав на запись в файл
  #
  def write_file(data)
    raise NotImplementedError, "Subclass must implement write_file"
  end

  public

  # Чтение всех студентов из файла
  #
  # Загружает данные из файла и преобразует их в массив объектов Student.
  # Автоматически вызывается при инициализации.
  #
  # @return [void]
  # @raise [Errno::ENOENT] если файл не существует
  # @raise [JSON::ParserError] для JSON формата при некорректных данных
  # @raise [Psych::SyntaxError] для YAML формата при некорректных данных
  #
  # @example
  #   list.read_all # Перезагружает данные из файла
  #
  def read_all
    @list = read_file.map { |student_data| Student.init_with_hash(student_data) }
  end

  
  # Запись всех студентов в файл
  #
  # Сохраняет текущее состояние списка студентов в файл.
  #
  # @return [void]
  # @raise [Errno::EACCES] если нет прав на запись в файл
  # @raise [Errno::ENOSPC] если недостаточно места на диске
  #
  # @example
  #   list.add_student(new_student)
  #   list.write_all # Сохраняет изменения в файл
  #
  def write_all
    write_file(@list)    
  end


  # Получение студента по идентификатору
  #
  # @param id [Integer] идентификатор студента
  # @return [Student, nil] объект Student если найден, иначе nil
  #
  # @example Поиск студента по ID
  #   student = list.get_by_id(1)
  #   if student
  #     puts "Найден: #{student.first_name}"
  #   else
  #     puts "Студент с ID=1 не найден"
  #   end
  #
  def get_by_id(id)
    @list.find { |student| student.id == id }
  end


 # Получить список k по счету n объектов класса Student_short
  #
  # @example Получить первые 10 студентов
  #   list.get_k_n_student_short_list(0, 10)
  #
  # @example Добавить в существующий список
  #   existing_list = DataList.new
  #   list.get_k_n_student_short_list(1, 10, existing_list)
  #
  # @param k [Integer] номер страницы (начинается с 0)
  # @param n [Integer] количество элементов на странице
  # @param existing_list [DataList<StudentShort>, nil] существующий список для добавления
  #
  # @return [DataList<StudentShort>] массив объектов StudentShort
  #
  def get_k_n_student_short_list(k, n, existing_list = nil)

    raise ArgumentError, "Expected class Integer, given #{k.class}" unless k.is_a?(Integer)
    raise ArgumentError, "Expected class Integer, given #{n.class}" unless n.is_a?(Integer)
    raise ArgumentError, "Expected k to be greater than 0" unless k > 0
    raise ArgumentError, "Expected n to be greater than 0" unless n > 0
    raise ArgumentError, "Expected class DataList, given #{existing_list.class}" if existing_list and !existing_list.is_a?(DataList)
    start_index = (k-1) * n + 1
    end_index = start_index + n
    
    slice = @list[start_index..end_index] || []
    student_shorts = slice.map { |student| StudentShort.from_student(student) }
    
    existing_list ? existing_list.replace(student_shorts) : DataList.new(student_shorts)
  end


  # Сортировка студентов по фамилии с инициалами
  #
  # Сортирует внутренний список студентов по полю last_name_initials.
  # Изменяет исходный список.
  #
  # @return [void]
  #
  # @example Сортировка и получение отсортированного списка
  #   list.sort_by_name
  #   sorted_students = list.k_n_student_short_list(0, 10)
  #
  # @see Student#last_name_initials
  #
  def sort_by_name
    @list = @list.sort_by{ |student| student.last_name_initials }
  end

  # Добавление нового студента в список
  #
  # @param student_hash [Student] хэш с данными студента для добавления
  # @return [Integer] сгенерированный ID нового студента
  #
  # @example Добавление студента
  #   new_id = list.insert({first_name: "Иван", last_name: "Петров"})
  #   list.write_all # для сохранения в файл
  #
  def insert(student_hash)
    new_id = @list.empty? ? 1 : @list.map(&:id).max + 1
    student_hash[:id] = new_id
    @list << Student.init_with_hash(student_hash)
    return true
  end

  # Замена студента по идентификатору
  #
  # @param id [Integer] ID студента для замены
  # @param student_hash [Student] хэш с данными студента
  # @return [Boolean] true если замена успешна, false если студент не найден
  #
  # @example Замена студента
  #   updated_student = Student.new(id: 1, first_name: "Иван", last_name: "Сидоров")
  #   if list.update_by_id(1, updated_student)
  #     list.write_all
  #     puts "Студент обновлен"
  #   end
  #
  def update_by_id(id, student_hash)
    index = @list.find_index { |student| student.id == id }
    return false unless index
    
    student_hash[:id] = id
    @list[index] = Student.init_with_hash(student_hash)
    true
  end


  # Удаление студента по идентификатору
  #
  # @param id [Integer] ID студента для удаления
  # @return [Boolean] true если удаление успешно, false если студент не найден
  #
  # @example Удаление студента
  #   if list.delete_by_id(1)
  #     list.write_all
  #     puts "Студент удален"
  #   end
  #
  def delete_by_id(id)
    curr_size = @list.size
    @list.delete(get_by_id(id))
    return get_student_short_count < curr_size
  end

  # Получение количества студентов в списке
  #
  # @return [Integer] количество студентов
  #
  # @example
  #   count = list.get_student_count
  #   puts "В списке #{count} студентов"
  #
  def get_student_short_count
    @list.size
  end

end