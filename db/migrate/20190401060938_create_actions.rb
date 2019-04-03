class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.references :project, type: :uuid, null: false
      t.references :owner, type: :uuid, null: false
      t.string :body, null: false, index: true

      t.timestamps(index: true, null: false)
    end
    add_foreign_key :actions, :users, column: :owner_id
    add_foreign_key :actions, :projects
  end
end
