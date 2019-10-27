class CreateTags < ActiveRecord::Migration[5.2]
  def change
    remove_reference :project_tags, :track, foreign_key: true, null: true
    remove_column :project_tags, :name, null: false

    create_table :tags do |t|
      t.string :name, null: false, index: true

      t.timestamps
    end

    add_reference :project_tags, :tag, foreign_key: true, null: false
  end
end
