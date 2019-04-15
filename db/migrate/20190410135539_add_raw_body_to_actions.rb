class AddRawBodyToActions < ActiveRecord::Migration[5.2]
  def change
    add_column :actions, :raw_body, :text, null: false, default: ''
  end
end
