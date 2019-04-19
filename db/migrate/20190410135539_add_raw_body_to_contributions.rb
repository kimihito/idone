class AddRawBodyToContributions < ActiveRecord::Migration[5.2]
  def change
    add_column :contributions, :raw_body, :text, null: false, default: ''
  end
end
