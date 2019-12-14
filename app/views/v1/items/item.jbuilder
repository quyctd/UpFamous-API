json do
  json.width @item.width
  json.height @item.height
  json.cloudinary_ver @item.cloudinary_ver
  json.cloudinary_id @item.cloudinary_id
  json.format @item.format
  json.user @item.user
  json.user_fullname @item.user.full_name
  json.likes @item.item_like_maps
  json.collections @item.collection_items
end