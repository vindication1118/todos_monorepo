class Organization < ApplicationRecord
  belongs_to :owner, class_name: "User"

  has_many :projects, dependent: :destroy
  has_many :organization_memberships, dependent: :destroy
  has_many :users, through: :organization_memberships

  validates :name, presence: true
end
