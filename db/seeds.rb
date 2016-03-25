# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(:name => "Admin",
            :mobile => "18530924885",
            :password => "yqwoe900316",
            :password_confirmation => "yqwoe900316")

Role.create(:name => "admin", :desc => "管理员")
Role.create(:name => "supervisor", :desc => "主管")
Role.create(:name => "staff", :desc => "招聘专员")
Role.create(:name => "userman", :desc => "用户管理")

Role.find_by(:name => "admin").users << User.find_by(:mobile => "18530924885")
Role.find_by(:name => "userman").users << User.find_by(:mobile => "18530924885")