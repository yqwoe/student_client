class Userinfo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  has_many :users

  def to_s
    name
  end
end
