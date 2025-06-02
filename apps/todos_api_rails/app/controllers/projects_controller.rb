class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: current_user.projects
  end

  def create
    org = current_user.projects.create!(project_params)
    render json: org
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
