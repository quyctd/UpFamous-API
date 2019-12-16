json.body do
  json.array! @collections, partial: 'collection', as: :clt
end