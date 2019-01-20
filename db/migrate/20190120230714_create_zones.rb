class CreateZones < ActiveRecord::Migration[5.2]
  def change
    create_table :zones do |t|
      t.references :region, foreign_key: true
      t.string :name
      t.string :slug
      t.boolean :default

      t.timestamps
    end
  end
end
