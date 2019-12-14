json.data do
  json.user do
    json.call(
      @user,
      :id,
      :first_name,
      :last_name,
      :username,
      :email,
      :authentication_token,
      :confirmed_at
    )
  end
end