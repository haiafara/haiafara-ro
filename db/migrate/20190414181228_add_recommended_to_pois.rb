class AddRecommendedToPOIs < ActiveRecord::Migration[5.2]
  def change
    add_column :pois, :recommended, :boolean, default: false
  end
end
