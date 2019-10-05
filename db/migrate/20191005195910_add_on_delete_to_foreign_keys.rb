class AddOnDeleteToForeignKeys < ActiveRecord::Migration[5.2]
  def up
    # projects
    remove_reference(:projects, :owner)
    add_reference(:projects, :owner, type: :uuid, null: false, index: true, foreign_key: { to_table: :users, on_delete: :cascade })

    # tracks
    remove_reference(:tracks, :project)
    add_reference(:tracks, :project, type: :uuid, null: false, index: true, foreign_key: { on_delete: :cascade })

    remove_reference(:tracks, :owner)
    add_reference(:tracks, :owner, type: :uuid, null: false, index: true, foreign_key: { to_table: :users, on_delete: :cascade })
  end

  def down
    # project
    remove_reference(:projects, :owner)
    add_reference(:projects, :owner, type: :uuid, null: false, index: true, foreign_key: { to_table: :users })

    # tracks
    remove_reference(:tracks, :project)
    add_reference(:tracks, :project, type: :uuid, null: false, index: true, foreign_key: true)

    remove_reference(:tracks, :owner)
    add_reference(:tracks, :owner, type: :uuid, null: false, index: true, foreign_key: { to_table: :users })
  end
end
