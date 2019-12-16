json.body do
  json.clt do
    json.partial! partial: 'collection', clt: @clt
  end
  json.items do
    json.array! @clt.items, partial: 'v1/items/item', as: :item
  end
end