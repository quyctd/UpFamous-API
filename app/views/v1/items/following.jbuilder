json.body do
  json.items @items do |item|
    json.partial! 'api/v1/items/show', item
  end
end
