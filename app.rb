require 'sinatra'
require 'pry'

require_relative './lib/db.rb'
require_relative './lib/auth.rb'

# Pry.start

get '/' do
  return unauthorized_response unless authorized?
  "welcome #{@user.name}!"
end
