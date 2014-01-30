require_relative 'config/application'
require './models/recipe'

# query the database here
Recipe.all.each { |recipe| puts recipe.rating}
# gets only the recipes with difficulty 3
puts recipes_with_difficulty_3 = Recipe.where('difficulty > 2')
# gets the top 10 difficult recipes
puts top_10_difficult_recipes = Recipe.where('difficulty > 2').limit(10)