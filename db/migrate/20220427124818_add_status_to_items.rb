class AddStatusToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :status, :integer, default: 0, null: false
  end
end
