module Entities
  class Course < Grape::Entity
    expose :id, documentation: {type: String, desc: 'id'}
    expose :name, documentation: {type: String, desc: '课程'}
  end
end