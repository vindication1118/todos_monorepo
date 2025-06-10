class CreateOrganizationMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :organization_memberships, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :organization, null: false, foreign_key: true, type: :uuid
      t.integer :organization_role, null: false, default: 0


      t.timestamps
    end
  end
end
