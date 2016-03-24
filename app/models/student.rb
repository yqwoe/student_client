class Student
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :mobile
  field :qq
  field :wx
  field :id_card
  field :pay_type #付款类型
  field :state,type: Integer ,default: 0 #0客户 1 开始学习

  has_many :comments
  belongs_to :course #课程
  belongs_to :school
  belongs_to :the
  belongs_to :department
  belongs_to :creator,:class_name=>"User" #每个招生专员下的学生
  def to_s
    name
  end
end
