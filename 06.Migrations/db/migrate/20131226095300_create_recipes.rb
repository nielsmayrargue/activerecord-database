class CreateRecipes < ActiveRecord::Migration
  def up	
    create_table :recipes do |t|
		  t.text :name
    	t.text :description
    	t.integer :length
    	t.integer :difficulty  
    	t.timestamps
    end
  end
end