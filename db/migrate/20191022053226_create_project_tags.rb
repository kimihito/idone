class CreateProjectTags < ActiveRecord::Migration[5.2]
  def change
    create_table :project_tags do |t|
      t.references :project, type: :uuid, null: true, foreign_key: true
      t.references :track, null: false, foreign_key: true

      t.timestamps
    end
  end
end
