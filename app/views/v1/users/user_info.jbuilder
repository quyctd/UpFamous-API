json.body do
  json.full_name @user.full_name
  json.first_name @user.first_name
  json.username @user.username
  json.follower @user.active_follower
  json.avatar @user.avatar
  json.photos do
    json.array! @user.items.newest, partial: 'v1/items/item', as: :item
  end
  json.likes do
    json.array! @user.like_items, partial: 'v1/items/item', as: :item
  end
  json.collections do
    json.array! @collections, partial: 'v1/collections/collection', as: :clt
  end
end