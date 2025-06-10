class CreateTodos < ActiveRecord::Migration[8.0]
  def change
    create_table :todos, id: :uuid do |t|
      t.string :title
      t.text :notes
      t.date :due_date
      t.string :status
      t.references :project, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
