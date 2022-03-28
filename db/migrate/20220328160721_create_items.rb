class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.string :item_image
      t.json :dress_images
      t.references :brand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
