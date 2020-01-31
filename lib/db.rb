require 'data_mapper'

DataMapper.setup :default, 'postgres://localhost/music_review'

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :email, String
  property :encrypted_password, Text
end

DataMapper.finalize

User.auto_upgrade!

