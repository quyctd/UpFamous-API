json.body do
  json.full_name @user.full_name
  json.first_name @user.first_name
  json.username @user.username
  json.follower @user.followers
  json.photos do
    json.array! @user.items.newest, partial: 'v1/items/item', as: :item
  end
  json.likes do
    json.array! @user.like_items, partial: 'v1/items/item', as: :item
  end
  json.collections do
    json.array! @user.collections, partial: 'v1/collections/collection', as: :collection
  end
end