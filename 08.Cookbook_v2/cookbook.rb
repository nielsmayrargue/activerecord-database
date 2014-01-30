require_relative 'config/application'
require './models/recipe'
require './models/user'


# your code here to query the database
puts User.count

# finds all the recipes that contain
User.all.each do |user|
	user_name = user.name
	recipes = user.recipes
	recipes_names = ""
	recipes.each { |recipe| recipes_names << recipe.name }
	puts "#{user_name} *** #{recipes_names}"
end