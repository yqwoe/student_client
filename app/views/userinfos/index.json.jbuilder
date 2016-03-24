json.array!(@userinfos) do |userinfo|
  json.extract! userinfo, :id
  json.url userinfo_url(userinfo, format: :json)
end
