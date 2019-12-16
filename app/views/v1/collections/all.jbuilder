json.body do
  json.array! @collections, partial: 'collection', as: :collection
end