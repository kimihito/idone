class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.references :project, type: :uuid, null: false, foreign_key: true
      t.references :owner, type: :uuid, null: false, foreign_key: { to_table: :users }
      t.text :raw_body, null: false, default: ''

      t.timestamps(index: true, null: false)
    end
  end
end
