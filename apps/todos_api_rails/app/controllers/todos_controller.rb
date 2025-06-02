class TodosController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: current_user.todos
  end

  def create
    org = current_user.Todos.create!(todo_params)
    render json: org
  end

  private

  def todo_params
    params.require(:todo).permit(:name)
  end
end
