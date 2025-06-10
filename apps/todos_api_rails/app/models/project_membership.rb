class ProjectMembership < ApplicationRecord
  belongs_to :user
  belongs_to :project

  enum :project_role, [ :member, :editor, :owner ]

  validates :project_role, presence: true
  validates :user_id, uniqueness: { scope: :project_id }
end
