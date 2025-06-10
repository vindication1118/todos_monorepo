class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:index, :create]
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /projects/:project_id/todos
  def index
    render json: @project.todos
  end

  # GET /todos/:id
  def show
    render json: @todo
  end

  # POST /projects/:project_id/todos
  def create
    todo = @project.todos.create!(todo_params)
    render json: todo, status: :created
  end

  # PATCH/PUT /todos/:id
  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: { errors: @todo.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /todos/:id
  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def set_project
    @project = current_user.projects.find_by(id: params[:project_id])
    return render json: { error: 'Project not found' }, status: :not_found unless @project
  end

  def set_todo
    @todo = Todo.joins(:project).where(projects: { user_id: current_user.id }).find_by(id: params[:id])
    return render json: { error: 'Todo not found' }, status: :not_found unless @todo
  end

  def todo_params
    params.require(:todo).permit(:title, :notes, :due_date, :status)
  end
end

