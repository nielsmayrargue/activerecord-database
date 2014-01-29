class AddRatings < ActiveRecord::Migration
  def up	
    change_table :recipes do |t|
		  t.integer :ratings
    end
  end
end