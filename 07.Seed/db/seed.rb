require './models/recipe'
require 'nokogiri'
require 'open-uri'
require 'pry'

# Seed you database with recipe data from marmiton

puts "Seeding database..."

# Here is a sample of ingredients (you are free to add some !)
ingredients = ["curry", "crevettes", "agneau", "pomme", "orange", "café", "asperges", "celeri", "dorade"]

# Your code goes here 
# 1. Scrape recipes data from marmiton for these ingredients

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

#je ne sais pas comment avoir la difficulté (chez moi les solutions de Felix ou Emmanuel ne marchent pas)