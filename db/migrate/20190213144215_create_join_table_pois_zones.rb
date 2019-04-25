class CreateJoinTablePOIsZones < ActiveRecord::Migration[5.2]
  def change
    create_join_table :pois, :zones do |t|
      t.index :poi_id
      t.index :zone_id
    end
  end
end
