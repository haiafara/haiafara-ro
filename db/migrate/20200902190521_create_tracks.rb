class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.string :name
      t.text :description
      t.string :slug
      t.boolean :recommended, default: false
      t.line_string :shape, geographic: true

      t.timestamps
    end
  end
end
