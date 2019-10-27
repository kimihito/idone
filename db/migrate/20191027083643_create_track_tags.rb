class CreateTrackTags < ActiveRecord::Migration[5.2]
  def change
    add_reference :tracks, :project, type: :uuid, null: true, foreign_key: true
    create_table :track_tags do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :track, null: false, foreign_key: true

      t.timestamps
    end
  end
end
