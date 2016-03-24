require 'grape'
require 'grape-swagger'
class StudentClientV1API < Grape::API
  content_type :json, 'application/json;charset=UTF-8'
  format :json

  mount UserV1API => 'user'
  mount SchoolV1API => 'school'
  mount StudentV1API => 'student'
  mount CommentV1API => 'comment'
  # mount CourseV1API => 'course'
  add_swagger_documentation base_path: 'api/v1', hide_format: true
end