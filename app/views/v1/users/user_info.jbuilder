json.body do
  json.first_name @user.first_name
  json.last_name @user.last_name
  json.username @user.username
  json.follower @user.followers
  json.photos @user.items
  json.likes @user.item_like_maps
  json.collections @user.collections
end