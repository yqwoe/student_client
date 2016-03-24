class CourseV1API < Grape::API

  format :json
  helpers do
    def current_user
      token = headers['Authentication-Token']
      @current_user = User.find_by(authentication_token: token)
    rescue
      error!('401 Unauthorized', 401)
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end
  end


  desc '获取课程', {
                 :headers => {
                     "Authentication-Token" => {
                         description: "用户Token",
                         required: true
                     }
                 },
                 :entity => Entities::Course
             }
  params do
  end
  post 'courses' do
    array=[]
    Course.all.each do |c|
      array << {id:c.id.to_s,name:c.name}
    end
    array
  end

end