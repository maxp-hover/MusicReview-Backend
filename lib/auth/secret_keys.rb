set :signing_key, OpenSSL::PKey.read(File.read("./app.rsa"))
set :verify_key, OpenSSL::PKey.read(File.read("./app.rsa.pub"))
set :session_secret, 'super secret'
