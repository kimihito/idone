class DropContributions < ActiveRecord::Migration[5.2]
  def change
    drop_table :contributions do |t|
      t.references :project, type: :uuid, null: false, foreign_key: true
      t.references :owner, type: :uuid, null: false, foreign_key: { to_table: :users }
      t.string :body, null: false, index: true, default: ""
      t.text :raw_body, null: false, default: ''

      t.timestamps(index: true, null: false)
    end
  end
end
