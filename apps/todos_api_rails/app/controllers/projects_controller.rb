class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization, only: [:create]
  before_action :set_project, only: [:show, :update, :destroy]

  # GET /organizations/:organization_id/projects
  def index
    render json: current_user.projects
  end

  # GET /organizations/:organization_id/projects/:id
  def show
    render json: @project
  end

  # POST /organizations/:organization_id/projects
  def create
    project = @organization.projects.create!(project_params.merge(user: current_user))
    render json: project, status: :created
  end

  # PATCH/PUT /organizations/:organization_id/projects/:id
  def update
    if @project.update(project_params)
      render json: @project
    else
      render json: { errors: @project.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /organizations/:organization_id/projects/:id
  def destroy
    @project.destroy
    head :no_content
  end

  private

  def set_organization
    @organization = current_user.organizations.find_by(id: params[:organization_id])
    return render json: { error: 'Organization not found' }, status: :not_found unless @organization
  end

  def set_project
    @project = current_user.projects.find_by(id: params[:id])
    return render json: { error: 'Project not found' }, status: :not_found unless @project
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
