require_relative 'config/application'
require './models/recipe'
require './models/user'


Recipe.destroy_all
User.destroy_all


user_1 = User.create()
user_2 = User.create(name: "Niels")
user_3 = User.create(name: "Pierre", email: "niels@gmail")
user_4 = User.create(name: "Jean", email: "niels@gmail.com")
user_11 = User.create(name: "Jean2", email: "niels2@gmail.com")
user_5 = User.create(name: "Jules", email: "niels@gmail.com")
recipe_1 = Recipe.create(name: "cerise")
recipe_2 = Recipe.create(name: "cerise")
recipe_3 = Recipe.create(difficulty: 3)


User.all.each do |user| 
	puts user.name
end