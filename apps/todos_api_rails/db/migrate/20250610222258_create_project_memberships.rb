class CreateProjectMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :project_memberships, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :project, null: false, foreign_key: true, type: :uuid
      t.integer :project_role, null: false, default: 0

      t.timestamps
    end

    add_index :project_memberships, [:user_id, :project_id], unique: true
  end
end
