json.name collection.name
json.describe collection.describe
json.status collection.status
json.feature_imgs collection.feature_imgs
json.imgs do
  json.array! collection.items, partial: 'v1/items/item', as: :item
end