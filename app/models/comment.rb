class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text
  belongs_to :student
  belongs_to :creator,:class_name => "User"

  def to_s
    text
  end

end
