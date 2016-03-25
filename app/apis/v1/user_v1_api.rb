class UserV1API < Grape::API
  include BCrypt
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

  desc '根据用户token获取[招聘专员]', {
                              :headers => {
                                  # "Authentication-Token" => {
                                  #     description: "用户Token",
                                  #     required: true
                                  # }
                              },
                              :entity => Entities::User
                          }
  params do
    requires :authenticationToken, type: String, desc: '用户登录Token'
  end
  post 'findstaffs' do
    user = User.find_by(authentication_token: params[:authenticationToken])
    array=[]
    if user.has_role? :supervisor

      user.childs.each do |u|
        array << {id: u.id.to_s, name: u.name, in_count: Student.where(:creator => u, :state => 1).count, client_count: Student.where(:creator => u, :state => 0).count}
      end
    else
      return {:message => "error"}
    end
    array
  end

  desc '根据招聘专员id获取[学生信息]', {
                             # :headers => {
                             #     "Authentication-Token" => {
                             #         description: "用户Token",
                             #         required: true
                             #     }
                             # },
                             :entity => Entities::Student
                         }
  params do
    optional :staff_id, type: String, desc: '招生专员[可为空]'
    requires :token, type: String, desc: 'token'
    requires :state, type: String, desc: 'state'
  end
  paginate per_page: 20, max_per_page: 30, offset: 5
  post 'findsstudents' do
    array=[]
    if params[:staff_id].present?
      user = User.find_by(authentication_token: params[:token])
      students=Student.where(:creator => User.find(params[:staff_id]), :state => params[:state]).order('created_at desc').page(params[:page]).per(params[:per_page])
      if user.has_role? :supervisor
        students.each do |u|
          array << {id: u.id.to_s, name: u.name, :mobile => u.mobile, qq: u.qq, wx: u.wx, id_card: u.id_card, pay_type: u.pay_type, course: u.course.to_s, school: u.school.to_s, department: u.department.to_s, the: u.the.to_s, state: u.state.to_s, :time => u.created_at}
        end
      else
        return {:message => "error"}
      end
    else
      @current_user=User.find_by(authentication_token: params[:token])
      if @current_user.has_role? :staff
        students=Student.where(:creator => @current_user, :state => params[:state]).order('created_at desc').page(params[:page]).per(params[:per_page])
        students.each do |u|
          array << {id: u.id.to_s, name: u.name, :mobile => u.mobile, qq: u.qq, wx: u.wx, id_card: u.id_card, pay_type: u.pay_type, course: u.course.to_s, school: u.school.to_s, department: u.department.to_s, the: u.the.to_s, state: u.state.to_s, :time => u.created_at}
        end
      else
        return {:message => "error"}
      end
    end

    array
  end


  desc '根据用户名及密码获取授权的token'
  params do
    requires :mobile, type: String, desc: '手机号'
    # requires :password, type: String, desc: '密码'
  end
  get :authenticationToken do
    begin
      u = User.find_by(mobile: params[:mobile])
    rescue
      u = nil
    end
    has={}
    if u.present?
      if u.has_role? :supervisor
        has= {role: 'supervisor', token: u.authentication_token}
      end
      if u.has_role? :staff
        has= {role: 'staff', token: u.authentication_token}
      end
    end
    has
  end
end