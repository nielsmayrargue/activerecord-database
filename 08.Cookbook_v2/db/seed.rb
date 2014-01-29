require './models/recipe'
require './models/user'
require 'faker'
require 'nokogiri'
require 'open-uri'
require 'pry'

# Seed you database with recipe data from marmiton
puts "Seeding database..."
# Here is a sample of ingredients (you are free to add some !)
ingredients = ["curry", "crevettes", "agneau", "pomme", "orange", "café", "asperges", "celeri", "dorade"]



# creates users with the Faker Gem

def create_fake_user
name = Faker::Name.name
email = Faker::Internet.email
User.create(name: name, email: email)
end

number_of_fake_users = 50
number_of_fake_users.times { create_fake_user }

# for each user, pick randomly one ingredient or more from the list of ingredients and attach recipes to the user

puts "Seeding database..."

def save_to_html_file(keyword)
open("http://www.marmiton.org/recettes/recherche.aspx?aqt=#{keyword}")
end

def parse(file)
	doc = Nokogiri::HTML(open(file))
	
	doc.xpath("//div[contains(@class,'m_search_result')]").each do |recipe_html|
		name = recipe_html.xpath("//div[contains(@class,'m_search_titre_recette')]/a/text()")
		description = recipe_html.xpath("//div[contains(@class,'m_search_result_part')]/text()")
		length = (/Préparation : \d+/).match(description.to_s).to_s.to_i
		rating = 0
		recipe_html.xpath("//div[contains(@class,'m_search_note_recette')]").each do |note|
			rating += 1 if note.include?("étoile1")
		end
		Recipe.create(name: name, description: description, length: length, rating: rating)
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
