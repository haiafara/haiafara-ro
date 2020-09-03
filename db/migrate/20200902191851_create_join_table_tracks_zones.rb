class CreateJoinTableTracksZones < ActiveRecord::Migration[6.0]
  def change
    create_join_table :tracks, :zones do |t|
      t.index :track_id
      t.index :zone_id
    end
  end
end
