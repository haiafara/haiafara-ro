class CreatePois < ActiveRecord::Migration[5.2]
  def change
    create_table :pois do |t|
      t.string :name
      t.text :description
      t.string :slug
      t.geometry :shape, geographic: true

      t.timestamps
    end
  end
end
