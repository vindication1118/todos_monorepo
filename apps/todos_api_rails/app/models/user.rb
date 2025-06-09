class User < ApplicationRecord
  # Encrypts password using bcrypt
  has_secure_password

  #validations
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: :password_digest_changed?
  validates :name, presence: true

  #associations for later
  # has_many :projects, through: :memberships
  # belongs_to :organization, optional: true
  # 
end
