class Student
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :mobile
  field :qq
  field :wx
  field :id_card
  field :pay_type ,type: Integer #付款类型
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


  scope :by_mobile,->(mobile){
    where(:mobile=>/#{mobile}/) if mobile.present?
  }
  scope :by_name,->(name){
    where(:mobile=>/#{name}/) if name.present?
  }
  scope :by_creator,->(c){
    where(:creator=>c) if c.present?
  }
  scope :by_school,->(s_id){
    where(:school_id=>s_id) if s_id.present?
  }
  scope :by_department,->(s_id){
    where(:department_id=>s_id) if s_id.present?
  }

end
