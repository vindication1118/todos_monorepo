class User < ApplicationRecord
  has_secure_password

  has_many :owned_organizations, class_name: "Organization", foreign_key: :owner_id, dependent: :destroy
  has_many :organization_memberships, dependent: :destroy
  has_many :organizations, through: :organization_memberships

  has_many :projects, dependent: :destroy  # if user is project creator
  has_many :todos, through: :projects  # optional convenience

  has_many :project_memberships, dependent: :destroy
  has_many :joined_projects, through: :project_memberships, source: :project


  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

end
