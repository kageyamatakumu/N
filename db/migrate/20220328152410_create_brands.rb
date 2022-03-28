class CreateBrands < ActiveRecord::Migration[6.1]
  def change
    create_table :brands do |t|
      t.string :name
      t.string :instagram_user_name
      t.date :start_up
      t.text :brand_description
      t.string :brand_image
      t.string :instagram_image
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
