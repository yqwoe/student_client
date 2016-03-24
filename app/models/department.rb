class Department
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  has_one :student

  def to_s
    name
  end
end
