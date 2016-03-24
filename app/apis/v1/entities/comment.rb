module Entities
  class Comment < Grape::Entity
    expose :id, documentation: {type: String, desc: 'id'}
    expose :text, documentation: {type: String, desc: '评论信息'}
    expose :student_id, documentation: {type: String, desc: '学生id'}
    expose :creator, documentation: {type: String, desc: '评论人'}
    expose :time, documentation: {type: String, desc: '评论时间'}
  end
end