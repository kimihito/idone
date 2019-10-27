class CreateProjectTags < ActiveRecord::Migration[5.2]
  def change
    remove_reference :tracks, :project, index: true, foreign_key: true

    create_table :project_tags do |t|
      t.references :project, type: :uuid, null: true, foreign_key: true
      t.references :track, null: true, foreign_key: true
      t.string :name, null: false, default: ''

      t.timestamps
    end
  end
end
