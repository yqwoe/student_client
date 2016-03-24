class Course #课程
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name

  has_many :students


  def to_s
    name
  end
end
