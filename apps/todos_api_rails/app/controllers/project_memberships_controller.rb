class ProjectMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action -> { authorize_project_owner_or_admin!(@project) }, only: [:index, :create]
  before_action -> { authorize_project_owner!(@project) }, only: [:update, :destroy]
  before_action :set_membership, only: [:update, :destroy]

  def index
    render json: @project.project_memberships.includes(:user)
  end

  def create
    membership = @project.project_memberships.create!(membership_params)
    render json: membership, status: :created
  end

  def update
    if @membership.update(project_role: params[:project_role])
      render json: @membership
    else
      render json: { errors: @membership.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @membership.destroy
    head :no_content
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_membership
    @membership = @project.project_memberships.find(params[:id])
  end

  def membership_params
    params.require(:project_membership).permit(:user_id, :project_role)
  end
end
