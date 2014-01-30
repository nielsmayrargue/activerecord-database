require './models/recipe'
require 'nokogiri'
require 'open-uri'
require 'pry'

# Seed you database with recipe data from marmiton

puts "Seeding database..."

Recipe.destroy_all

# Here is a sample of ingredients (you are free to add some !)
ingredients = ["curry"]

# Your code goes here 
# 1. Scrape recipes data from marmiton for these ingredients

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

#je ne sais pas comment avoir la difficulté (chez moi les solutions de Felix ou Emmanuel ne marchent pas)