helpers do

  def extract_token
    params[:token]
  end

  def authorized?
    @token = extract_token
    begin
      payload, header = JWT.decode(@token, settings.verify_key, true)
      @user = User.get payload["user_id"]
      return false unless @user
      true
    rescue JWT::DecodeError => e
      return false
    end
  end

  def unauthorized_response(custom_msg = nil)
    status 401
    custom_msg || "unauthorized"
  end
end
