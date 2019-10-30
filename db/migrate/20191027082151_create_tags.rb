class CreateTags < ActiveRecord::Migration[5.2]
  def change
    remove_reference :tracks, :project, index: true, foreign_key: true
    create_table :tags do |t|
      t.string :name, null: false, index: true
      t.references :project, foreign_key: true, type: :uuid, null: true

      t.timestamps
    end
    add_reference :tracks, :tag, index: true, foreign_key: true, null: false
  end
end
