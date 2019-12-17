json.body do
  json.first_name @user.first_name
  json.last_name @user.last_name
  json.username @user.username
  json.email @user.email
  json.location @user.location
  json.bio @user.bio
  json.avatar @user.avatar
  json.tags @user.tags
end