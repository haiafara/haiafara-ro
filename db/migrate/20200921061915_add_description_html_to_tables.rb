class AddDescriptionHtmlToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :zones, :description_html, :text
    add_column :pois, :description_html, :text
    add_column :photos, :description_html, :text
  end
end
