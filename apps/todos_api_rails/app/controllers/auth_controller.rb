class AuthController < ApplicationController
  # POST /signup
  def signup
    user = User.new(user_params)
    if user.save
      token = encode_token(user_id: user.id)
      render json: { user: user, token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # POST /login
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = encode_token(user_id: user.id)
      render json: { user: user, token: token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def me
    authenticate_user!
    render json: current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base)
  end


end
