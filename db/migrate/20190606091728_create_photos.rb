class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :name
      t.text :description
      t.text :image_data
      t.references :photoable, polymorphic: true

      t.timestamps
    end
  end
end
