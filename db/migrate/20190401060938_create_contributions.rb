class CreateContributions < ActiveRecord::Migration[5.2]
  def change
    create_table :contributions do |t|
      t.references :project, type: :uuid, null: false
      t.references :owner, type: :uuid, null: false
      t.string :body, null: false, index: true, default: ""

      t.timestamps(index: true, null: false)
    end
    add_foreign_key :contributions, :users, column: :owner_id
    add_foreign_key :contributions, :projects
  end
end
