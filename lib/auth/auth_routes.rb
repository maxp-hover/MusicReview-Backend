require 'pry'

get '/logout' do
  ["logged out"].to_json
end

post '/login' do
  user = User.first(name: params[:username])

  if !user
    return unauthorized_response("No user found with that name")
  end
  if !BCrypt::Password.new(user.encrypted_password).is_password?(params[:password])
    return unauthorized_response("Invalid password")
  end

  token = JWT.encode(
    {user_id: user.id},
    settings.signing_key,
    "RS256", headers
  )

  { access_token: token, user_id: user.id, name: user.name }.to_json
end

post '/register' do
  user = User.first(name: params[:username])

  if user
    return unauthorized_response("Username already taken")
  end

  user = User.create(
    name: params[:username],
    encrypted_password: BCrypt::Password.create(params[:password])
  )

  token = JWT.encode(
    {user_id: user.id},
    settings.signing_key,
    "RS256", headers
  )

  { access_token: token, user_id: user.id, name: user.name }.to_json
end
