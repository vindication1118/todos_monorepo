class SessionsController < ApplicationController

  # POST /session
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = JWT.encode({ user_id: user.id }, Rails.application.secret_key_base)
      render json: { token: token }, status: :created
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  # DELETE /session
  def destroy
    # JWT-based auth is stateless, placeholder for now if I decide to change or add auth options
    head :no_content
  end
end
