class TodoSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :due_date, :notes

  belongs_to :project
end
