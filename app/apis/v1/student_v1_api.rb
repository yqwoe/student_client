class StudentV1API < Grape::API
  include Grape::Kaminari
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
                   # :headers => {
                   #     "Authentication-Token" => {
                   #         description: "用户Token",
                   #         required: true
                   #     }
                   # },
                   :entity => Entities::Student
               }
  params do
    requires :student, type: String, desc: '学生信息{"name":"学生姓名","mobile":"手机号","qq":"qq","wx":"微信","id_card":"身份证","pay_type":"支付类型0全款1分期","course":"课程id","school":"学校id","department":"专业id","the":"年届id","state":"是否开始学习 0客户1开始学习"
}'
  end
  post 'createstudent' do
    json=JSON.parse(params[:student])
    token=json['token']
    json=json.delete_if { |k, v| k == 'token' }
    student=Student.new(json)
    student.creator=User.find_by(authentication_token: token)
    if student.save
      {:success => true, :student_id => student.id.to_s}
    else
      error!({"message" => terminator.errors}, 403)
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
    requires :student_id, type: String, desc: '学生id'
    requires :state, type: String, desc: '学生id'
  end
  post 'updatestudent' do
    p "#{params}"
    student=Student.find(params[:student_id])
    student.state=params[:state].to_i
    if student.save
      {:success => true, :id => student.id}
    else
      error!({"message" => terminator.errors}, 403)
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
    requires :school_id, type: String, desc: '学校id'
    requires :department_id, type: String, desc: '专业id'
    optional :staff_id, type: String, desc: '专业id'
  end
  paginate per_page: 20, max_per_page: 30, offset: 5
  post 'students' do
    p "===============#{params['Authentication-Token']}"
    # conditions={}
    array=[]
    # if params[:school_id].present?
    #   conditions={:school_id => params[:school_id]}
    # end
    # if params[:department_id].present?
    #   conditions={:department_id => params[:department_id]}
    # end
    # if params[:school_id].present? && params[:department_id].present?
    #   conditions={:school_id => params[:school_id], :department_id => params[:department_id]}
    # end
    if params[:staff_id].present?
      student=Student.by_school(params[:school_id])
                  .by_department(params[:department_id]).by_creator(User.find(params[:staff_id]))
                  .order('created_at desc').page(params[:page]).per(params[:per_page])
    else

      student=Student.by_school(params[:school_id])
                  .by_department(params[:department_id]).by_creator(User.find_by(authentication_token: params['Authentication-Token'])).page(params[:page]).order('created_at desc').per(params[:per_page])
    end

    student.each do |u|
      array << {id: u.id.to_s, name: u.name, :mobile => u.mobile, qq: u.qq, wx: u.wx, id_card: u.id_card, pay_type: u.pay_type, course: u.course.to_s, school: u.school.to_s, department: u.department.to_s, the: u.the.to_s, state: u.state.to_s, :time => u.created_at}
    end
    array
  end



  desc '查询学生信息', {
                   :headers => {
                       "Authentication-Token" => {
                           description: "用户Token",
                           required: true
                       }
                   },
                   :entity => Entities::Student
               }
  params do
    optional :mobile, type: String, desc: '手机号'
    optional :name, type: String, desc: '名字'
    optional :staff_id, type: String, desc: '招聘专员id'
  end
  # paginate per_page: 20, max_per_page: 30, offset: 5
  post 'search' do
    p "===============#{params['Authentication-Token']}"
    array=[]
    if params[:staff_id].present?
      student=Student.by_mobile(params[:mobile]).by_name(params[:name]).by_creator(User.find(params[:staff_id]))
                  .order('created_at desc')
    else

      student=Student.by_mobile(params[:mobile])
                  .by_name(params[:name])
                  .by_creator(User.find_by(authentication_token: params['Authentication-Token'])).order('created_at desc')
    end

    student.each do |u|
      array << {id: u.id.to_s, name: u.name, :mobile => u.mobile, qq: u.qq, wx: u.wx, id_card: u.id_card, pay_type: u.pay_type, course: u.course.to_s, school: u.school.to_s, department: u.department.to_s, the: u.the.to_s, state: u.state.to_s, :time => u.created_at}
    end
    array
  end

end