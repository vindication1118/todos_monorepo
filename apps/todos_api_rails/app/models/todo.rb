class Todo < ApplicationRecord
  belongs_to :project

  validates :title, presence: true
  validates :status, inclusion: { in: %w[pending in_progress complete archived], allow_nil: true }
end
