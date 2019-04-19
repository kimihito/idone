class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')
    create_table :projects, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.references :owner, type: :uuid, null: false
      t.string :title, null: false, index: true

      t.timestamps(index: true, null: false)
    end
    add_foreign_key :projects, :users, column: :owner_id
  end
end
