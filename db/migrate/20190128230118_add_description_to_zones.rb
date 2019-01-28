class AddDescriptionToZones < ActiveRecord::Migration[5.2]
  def change
    add_column :zones, :description, :text
  end
end
