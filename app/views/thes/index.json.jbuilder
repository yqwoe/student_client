json.array!(@thes) do |the|
  json.extract! the, :id, :name
  json.url the_url(the, format: :json)
end
