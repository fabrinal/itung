json.array!(@accounts) do |account|
  json.extract! account, :id, :account_name, :account_type, :value, :description
  json.url account_url(account, format: :json)
end
