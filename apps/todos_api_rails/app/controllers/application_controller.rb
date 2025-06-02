class ApplicationController < ActionController::API
    def current_user
      auth_header = request.headers['Authorization']
      return unless auth_header
      token = auth_header.split(' ').last
      decoded = JWT.decode(token, Rails.application.secret_key_base)[0]
      User.find(decoded["user_id"])
    rescue
      nil
    end

    def authenticate_user!
      render json: { error: "Not Authorized" }, status: :unauthorized unless current_user
    end
  end
