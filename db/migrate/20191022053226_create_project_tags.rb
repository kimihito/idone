class CreateProjectTags < ActiveRecord::Migration[5.2]
  def change
    create_table :project_tags do |t|

      t.timestamps
    end
  end
end
