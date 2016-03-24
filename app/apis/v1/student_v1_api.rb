class StudentV1API < Grape::API

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

  desc '创建学生信息', {
                              :headers => {
                                  "Authentication-Token" => {
                                      description: "用户Token",
                                      required: true
                                  }
                              },
                              :entity => Entities::Student
                          }
  params do
    requires :student, type: String, desc: '学生信息{"name":"学生姓名","mobile":"手机号","qq":"qq","wx":"微信","id_card":"身份证","pay_type":"支付类型0全款1分期","course":"课程id","school":"学校id","department":"专业id","the":"年届id","state":"是否开始学习 0客户1开始学习"
}'
  end
  post 'createstudent' do
    json=JSON.parse(params[:student])
    student=Student.new(json)
    student.creator=@current_user
    if student.save
      {:success => true, :id => student.id}
    else
      error!({"message" => terminator.errors}, 403)
    end
  end

end