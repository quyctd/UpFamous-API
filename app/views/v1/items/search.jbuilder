json.body do
  json.items do
    json.array! @photos, partial: 'item', as: :item
  end
  json.collections do
    json.array! @collections, partial: 'v1/collections/collection', as: :clt
  end
  json.users do
    json.array! @users
  end
end
