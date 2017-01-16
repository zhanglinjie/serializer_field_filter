require "spec_helper"
describe SerializerFieldFilter::Relation do
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

  let(:classroom)    { Classroom.new(id: 1, name: "classroom") }
  let(:teacher)   { Teacher.new(id: 1, name: "teacher") }
  let(:student_1) { Student.new(id: 1, name: "student") }
  let(:student_2) { Student.new(id: 2, name: "student") }
  let(:cource)    { Cource.new(id: 1, name: "cource", classroom: classroom, teacher: teacher, students: [student_1, student_2])}

  subject(:json) {
    ActiveModelSerializers::SerializableResource.new(cource, filter&.resource_options || {}).as_json
  }

  context "with all field" do
    let(:filter) { SerializerFieldFilter::AllField.new }
    it { should eq({
        id: 1,
        name: 'cource',
        classroom: { id: 1, name: 'classroom' },
        teacher: { id: 1, name: 'teacher' },
        students: [
          { id: 1, name: 'student' },
          { id: 2, name: 'student' }
        ]
      })
     }
  end

  context "with nil" do
    let(:filter) { nil }
    it { should eq({
        id: 1,
        name: 'cource',
        classroom: { id: 1, name: 'classroom' },
        teacher: { id: 1, name: 'teacher' },
        students: [
          { id: 1, name: 'student' },
          { id: 2, name: 'student' }
        ]
      })
     }
  end

  context "with none field" do
    let(:filter) { SerializerFieldFilter::NoneField.new  }
    it { should eq({})}
  end

  context "with root partial field" do
    let(:filter) { SerializerFieldFilter.init(['id'])  }
    it { should eq({ id: 1 }) }
  end

  context "with has_one all fields" do
    let(:filter) { SerializerFieldFilter.init(['classroom'])  }
    it { should eq({
        classroom: { id: 1, name: 'classroom' }
      })
    }
  end

  context "with has_one partial fields" do
    let(:filter) { SerializerFieldFilter.init(['classroom.id'])  }
    it { should eq({
        classroom: { id: 1 }
      })
    }
  end

  context "with belongs_to all fields" do
    let(:filter) { SerializerFieldFilter.init(['teacher'])  }
    it { should eq({
        teacher: { id: 1, name: 'teacher' }
      })
    }
  end

  context "with belongs_to partial fields" do
    let(:filter) { SerializerFieldFilter.init(['teacher.id'])  }
    it { should eq({
        teacher: { id: 1 }
      })
    }
  end

  context "with has_many all fields" do
    let(:filter) { SerializerFieldFilter.init(['students'])  }
    it { should eq({
        students: [
          { id: 1, name: 'student' },
          { id: 2, name: 'student' }
        ]
      })
    }
  end

  context "with has_many partial fields" do
    let(:filter) { SerializerFieldFilter.init(['students.id'])  }
    it { should eq({
        students: [
          { id: 1 },
          { id: 2 }
        ]
      })
    }
  end
end
