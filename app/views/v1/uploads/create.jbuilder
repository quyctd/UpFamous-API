json.data do
  json.user do
    json.call(
      @user
    )
    json.array! @items
    json.array! @ret
  end
end
