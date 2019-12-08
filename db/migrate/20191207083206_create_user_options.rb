class CreateUserOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_options do |t|
      t.column :email_privacy, :integer, default: 0, null: false
      t.references :user, foreign_key: true, type: :uuid, null: false

      t.timestamps
    end
  end
end
