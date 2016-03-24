module Entities
  class User < Grape::Entity
    expose :id, documentation: {type: String, desc: '用户id'}
    expose :name, documentation: {type: String, desc: '名字'}
    expose :in_count, documentation: {type: String, desc: '入学数'}
    expose :client_count, documentation: {type: String, desc: '客户数'}
  end
end