class ApplicationController < ActionController::API
    def current_user
      auth_header = request.headers['Authorization']
      return unless auth_header
      token = auth_header.split(' ').last
      decoded = JWT.decode(token, Rails.application.secret_key_base)[0]
      User.find(decoded["user_id"])
    rescue
      nil
    end

    def authenticate_user!
      render json: { error: "Not Authorized" }, status: :unauthorized unless current_user
    end

    def require_org_owner!(org)
      render json: { error: "Forbidden" }, status: :forbidden unless org.owner == current_user
    end

    def require_org_admin!(org)
      membership = org.organization_memberships.find_by(user: current_user)
      render json: { error: "Forbidden" }, status: :forbidden unless membership&.admin? || org.owner == current_user
    end

    def current_project_membership(project)
      project.project_memberships.find_by(user_id: current_user.id)
    end

    def authorize_project_owner_or_admin!(project)
      membership = current_project_membership(project)

      unless membership&.project_role.in?(%w[owner admin])
        render json: { error: "Forbidden" }, status: :forbidden
      end
    end

    def authorize_project_owner!(project)
      membership = current_project_membership(project)

      unless membership&.project_role == "owner"
        render json: { error: "Only project owners can perform this action" }, status: :forbidden
      end
    end



  end
