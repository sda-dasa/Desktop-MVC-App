require_relative './config/MongoDB'

def seed_students
  collection_name = 'student'
  mg_instance = MGDB.instance
  students_data = [
    {id: 1,  first_name: 'Иван', last_name: 'Петров', email: 'ivan.petrov@example.com'},
    { id: 2, first_name: 'Мария', last_name: 'Иванова', email: 'maria.ivanova@example.com'},
    { id: 3, first_name: 'Алексей', last_name: 'Сидоров', email: 'aleksey.sidorov@example.com'},
    { id: 4, first_name: 'Елена', last_name: 'Кузнецова', email: 'elena.kuznetsova@example.com'},
    {id: 5, first_name: 'Дмитрий', last_name: 'Смирнов', email: 'dmitry.smirnov@example.com'},
    {id: 6,  first_name: 'Елена', last_name: 'Петрова', email: 'elena.petrova@example.com'},
    {id: 7, first_name: 'Семен', last_name: 'Зернов', email: 'semen.zernov@example.com'},
    {id: 8, first_name: 'Георгий', last_name: 'Скворцов', email: 'georgiy.skvorzov@example.com'},
    {id: 9, first_name: 'Арина', last_name: 'Светлова', email: 'elena.svetlova@example.com'},
    {id: 10, first_name: 'Светлана', last_name: 'Анохина', email: 'svetlana.anohina@example.com'}
  ]

  begin
    conn = mg_instance.connect[collection_name]
    conn.delete_many
    students_data.each do |student|
      begin
        conn.insert_one(student)
      rescue Mongo::Error => e
        puts "Rows insertion error #{e.message}\n #{student}"
      end
    end

  rescue Mongo::Error => e
    puts "Rows insertion error #{e.message}"
  end

end

seed_students