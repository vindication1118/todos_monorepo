class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :organization
  belongs_to :user
  has_many :todos
  has_many :project_memberships
end
