require_relative 'config/application'
require './models/recipe'


Recipe.create(name: 'test recette', description: 'test description')
Recipe.all.each { |recipe| puts "#{recipe.name} #{recipe.description}"}