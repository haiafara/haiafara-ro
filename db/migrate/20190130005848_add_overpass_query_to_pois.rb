class AddOverpassQueryToPOIs < ActiveRecord::Migration[5.2]
  def change
    add_column :pois, :overpass_query, :text
  end
end
