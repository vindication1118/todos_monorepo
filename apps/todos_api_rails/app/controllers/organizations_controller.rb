class OrganizationsController < ApplicationController
    before_action :authenticate_user!

    def index
      render json: current_user.organizations
    end

    def create
      org = current_user.organizations.create!(organization_params)
      render json: org
    end

    private

    def organization_params
      params.require(:organization).permit(:name)
    end
  end
