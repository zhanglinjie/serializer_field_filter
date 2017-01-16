## serializer_field_filter

field filter for active_model_serializer[https://github.com/rails-api/active_model_serializers]


### Install

gem install 'serializer_field_filter'

### Useage

```Ruby
  class BaseSerializer < ActiveModel::Serializer
    include SerializerFieldFilter::Relation
  end

  class CourceSerializer < BaseSerializer
    attributes :id, :name
    has_one_with_filter :classroom
    belongs_to_with_filter :teacher
    has_many_with_filter :students
  end

  class ClassroomSerializer < BaseSerializer
    attributes :id, :name
  end

  class TeacherSerializer < BaseSerializer
    attributes :id, :name
  end

  class StudentSerializer < BaseSerializer
    attributes :id, :name
  end

  class BaseModel
    include ActiveModel::Model
    include ActiveModel::Serialization
  end

  class Cource < BaseModel
    attr_accessor :id, :name, :classroom, :teacher, :students
  end

  class Classroom < BaseModel
    attr_accessor :id, :name
  end

  class Teacher < BaseModel
    attr_accessor :id, :name
  end

  class Student < BaseModel
    attr_accessor :id, :name
  end

  classroom = Classroom.new(id: 1, name: "classroom")
  teacher   = Teacher.new(id: 1, name: "teacher")
  student_1 = Student.new(id: 1, name: "student")
  student_2 = Student.new(id: 2, name: "student")
  cource    = Cource.new(id: 1, name: "cource", classroom: classroom, teacher: teacher, students: [student_1, student_2])

  filter = SerializerFieldFilter.init(%w(id name classroom teacher.name students.id))

  json = ActiveModelSerializers::SerializableResource.new(cource, filter.resource_options).as_json
  # => {
  #   id: 1,
  #   name: 'cource',
  #   classroom: { id: 1, name: 'classroom' },
  #   teacher: { name: 'teacher' },
  #   students: [
  #     { id: 1 },
  #     { id: 2 }
  #   ]
  # }
  ```
