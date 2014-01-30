require './models/recipe'
require './models/user'
require 'faker'
require 'nokogiri'
require 'open-uri'
require 'pry'

# Seed you database with recipe data from marmiton
puts "Seeding database..."
# Here is a sample of ingredients (you are free to add some !)
ingredients = ["curry","dorade"]



# creates users with the Faker Gem

def create_fake_user
User.create(name: Faker::Name.name, email: Faker::Internet.email)
end

number_of_fake_users = 50
number_of_fake_users.times { create_fake_user }

# for each user, pick randomly one ingredient or more from the list of ingredients and attach recipes to the user

puts "Seeding database..."

ingredients = ["curry"]

def save_to_html_file(keyword)
open("http://www.marmiton.org/recettes/recherche.aspx?aqt=#{keyword}")
end

def parse(file)
	doc = Nokogiri::HTML(open(file))
	doc.search('.m_search_result').each do |element|
		name = element.search('.m_search_titre_recette a').inner_text
		description = element.search('.m_search_result_part4').inner_text
		length = (/(\d+)/).match(description)[0].to_i
		rating = element.search('.etoile1').size
		Recipe.create(name: name, description: description, length: length, rating: rating, difficulty: rand(1..5))
	end	
end

ingredients.each do |ingredient|
  file = save_to_html_file(ingredient)
  parse(file)
end

Recipe.all.each do |recipe|
	user_id = rand(1..number_of_fake_users)
	recipe.update(user_id: user_id)
end
