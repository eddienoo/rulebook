json.array!(@rules) do |rule|
  json.extract! rule, :id, :title, :content, :created_at, :updated_at, :valid_until
  json.url rule_url(rule, format: :json)
end
