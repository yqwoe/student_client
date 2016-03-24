class CommentV1API < Grape::API

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

  desc '评论', {
                   :headers => {
                       "Authentication-Token" => {
                           description: "用户Token",
                           required: true
                       }
                   },
                   :entity => Entities::Comment
               }
  params do
    requires :student_id, type: String, desc: '学生id'
    requires :text, type: String, desc: '评论信息'
  end
  post 'createcomment' do
    student=Student.find(params[:student_id])
    comment=Comment.new(:student=>student,:text=>params[:text],:creator=>@current_user)
    if comment.save
      {id:comment.id.to_s,text:comment.text,student_id:comment.student_id.to_s,creator:comment.creator.to_s,time:comment.created_at}
    else
      error!({"message" => terminator.errors}, 403)
    end
  end

  desc '获取评论', {
               :headers => {
                   "Authentication-Token" => {
                       description: "用户Token",
                       required: true
                   }
               },
               :entity => Entities::Comment
           }
  params do
    requires :student_id, type: String, desc: '学生id'
  end
  post 'comments' do
    student=Student.find(params[:student_id])
    comments=Comment.where(:student=>student).order('created_at desc')
    array=[]
    comments.each do |c|
      array << {id:c.id.to_s,text:c.text,student_id:c.student_id.to_s,creator:c.creator.to_s,time:c.created_at}
    end
    array
  end

end