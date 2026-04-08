require_relative '../../db/config/MongoDB'

def create_student_table_mgdb
  conn = MGDB.instance.connect.database
  conn[:student].drop
  conn[:student].create
  conn[:student].indexes.create_one({ id: 1 }, unique: true)
  conn[:student].indexes.create_one({ email: 1 }, { unique: true, sparse: true })
  conn[:student].indexes.create_one({ phone: 1 }, { unique: true, sparse: true })
  conn[:student].indexes.create_one({ telegram: 1 }, { unique: true, sparse: true })
  conn[:student].indexes.create_one({ git: 1 }, { unique: true, sparse: true })
end

create_student_table_mgdb