class Project < ApplicationRecord
  belongs_to :organization
  belongs_to :user  # creator/owner of the project

  has_many :todos, dependent: :destroy

  has_many :project_memberships, dependent: :destroy
  has_many :users, through: :project_memberships


  validates :name, presence: true
end
