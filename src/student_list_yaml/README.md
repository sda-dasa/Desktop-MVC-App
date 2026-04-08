# StudentsListYAML

Ruby gem for managing student lists using YAML format with full CRUD operations.

## Installation

### From RubyGems

```bash
gem install students_list_yaml_hromushina
```

## Usage
```ruby
require 'students_list_yaml'
require 'student'  
list = StudentsListYamlGem::StudentsListYAML.new('students.yaml')
```

## Methods

get_student_by_id(id)
Найти студента по ID

add_student(student)
Добавить нового студента в список (автоматически генерирует ID)

get_k_n_student_short_list(k, n)
Получить k студентов начиная с n-ой позиции 

sort_by_last_name_initials()
Отсортировать студентов по ФИО (фамилия + инициалы)

replace_student(id, new_student)
Заменить студента по ID на нового

delete_student(id)
Удалить студента по ID

get_student_short_count()
Получить количество студентов в списке

read_from_file()
Загрузить данные из YAML файла

write_to_file()
Сохранить данные в YAML файл



