module Entities
  class Student < Grape::Entity
    expose :id, documentation: {type: String, desc: '用户id'}
    expose :name, documentation: {type: String, desc: '名字'}
    expose :mobile, documentation: {type: String, desc: '手机号'}
    expose :qq, documentation: {type: String, desc: 'qq'}
    expose :wx, documentation: {type: String, desc: '微信'}
    expose :id_card, documentation: {type: String, desc: '身份证号'}
    expose :pay_type, documentation: {type: String, desc: '付款类型 0 全款 1分期'}
    expose :course, documentation: {type: String, desc: '课程'}
    expose :school, documentation: {type: String, desc: '学校'}
    expose :department, documentation: {type: String, desc: '专业'}
    expose :the, documentation: {type: String, desc: '年届'}
    expose :creator, documentation: {type: String, desc: '招生专员'}
    expose :comments, documentation: {type: Comment, desc: '评论'}
    expose :state, documentation: {type: String, desc: '#0客户 1 开始学习'}
    expose :time, documentation: {type: String, desc: '录入时间'}
  end
end