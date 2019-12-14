json.body do
  json.full_name @user.full_name
  json.first_name @user.first_name
  json.username @user.username
  json.follower @user.followers
  json.photos @photos
  json.likes @user.item_like_maps
  json.collections @user.collections
end