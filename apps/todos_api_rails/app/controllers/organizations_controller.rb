class OrganizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_organization, only: [:show, :update, :destroy]

  # GET /organizations
  def index
    render json: current_user.organizations
  end

  # GET /organizations/:id
  def show
    render json: @organization
  end

  # POST /organizations
  def create
    org = Organization.create!(organization_params.merge(owner: current_user))
    org.organization_memberships.create!(user: current_user, organization_role: :owner)
    render json: org, status: :created
  end


  # PATCH/PUT /organizations/:id
  def update
    if @organization.update(organization_params)
      render json: @organization
    else
      render json: { errors: @organization.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /organizations/:id
  def destroy
    @organization.destroy
    head :no_content
  end

  private

  def set_organization
    @organization = current_user.organizations.find_by(id: params[:id])
    return render json: { error: 'Not found' }, status: :not_found unless @organization
  end

  def organization_params
    params.require(:organization).permit(:name)
  end
end
