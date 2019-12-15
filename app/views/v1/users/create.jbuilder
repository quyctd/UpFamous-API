json.body do
  json.user do
    json.id @user.id
    json.first_name @user.first_name
    json.last_name @user.last_name
    json.username @user.username
    json.email @user.email
    json.authentication_token @user.authentication_token
    json.collections do
      json.array! @user.collections, partial: 'v1/collections/collection', as: :collection
    end
  end
end