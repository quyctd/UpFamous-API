json.body do
  json.cloudinary_ver @item.cloudinary_ver
  json.cloudinary_id @item.cloudinary_id
  json.format @item.format
  json.created_at @item.created_at
  json.width @item.width
  json.height @item.height
  json.username @item.user.username
end