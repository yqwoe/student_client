class SchoolV1API < Grape::API
  include BCrypt

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


  desc '学校'
  params do

  end
  post 'schools' do
    array=[]
    School.all.each do |s|
      array << {id:s.id.to_s,name:s.name}
    end
    darray=[]
    Department.all.each do |s|
      darray << {id:s.id.to_s,name:s.name}
      end
    tarray=[]
      The.all.each do |s|
        tarray << {id:s.id.to_s,name:s.name}
      end
    {'school':array,'department':darray,'the':tarray}
  end
#   desc '专业'
#   params do
#
#   end
#   post 'departments' do
#     array=[]
#     Department.all.each do |s|
#       array << {id:s.id.to_s,name:s.name}
#     end
#     array
#   end
#   desc '年届'
#   params do
#
#   end
#   post 'thes' do
#     array=[]
#     The.all.each do |s|
#       array << {id:s.id.to_s,name:s.name}
#     end
#     array
#   end
end