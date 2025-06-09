class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:create] # allow signup

  def index
    render json: [current_user]
  end

  #read
  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def update
    @user = User.find(params[:id])

    if @user == @current_user && @user.update(user_params)
      render json: @user
    else
      render json: { error: "Unauthorized or invalid update" }, status: :unauthorized
    end
  end

  #delete, but with callbacks 
  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      @user.destroy
      head :no_content
    else
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
