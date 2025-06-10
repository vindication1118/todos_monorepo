class OrganizationMembership < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  enum :organization_role, [ :member, :admin, :owner ]

  validates :organization_role, presence: true
  validates :user_id, uniqueness: { scope: :organization_id }
end
