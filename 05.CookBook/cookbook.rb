require_relative 'config/application'
require './models/recipe'

# your program here

choice = ""

until choice == 6

  puts "Salut Robuchon, what do you want to do today?"
  puts "1. create a recipe"
  puts "2. delete all recipes"
  puts "3. read your recipes"
  puts "4. update a recipe"
  puts "5. delete a recipe"
  puts "6. exit"

  choice = gets.chomp.to_i
  puts "************"

  case choice
   when 1
    puts "type a name"
    name = gets.chomp
    puts "type a description"
    description = gets.chomp
    puts "type a length"
    length = gets.chomp
    puts "type a difficulty"
    difficulty = gets.chomp
    Recipe.create(name: name, description: description, length: length, difficulty: difficulty)
  when 2
    Recipe.all.each { |recipe| recipe.destroy}
  when 3
    Recipe.all.each do |recipe|
      puts "#{recipe.id}. #{recipe.name} #{recipe.description} #{recipe.length} #{recipe.difficulty}"
    end
  when 4
   puts "which recipe would you like to update ? type its number"
   Recipe.all.each do |recipe|
      puts "#{recipe.id}. #{recipe.name} #{recipe.description} #{recipe.length} #{recipe.difficulty}"
    end
    id_of_the_recipe = gets.chomp.to_i
    puts "do you want to change the name, description, length or difficulty ?"
    element_to_change = gets.chomp
    puts "write the new element"
    new_element = gets.chomp
    recipe = Recipe.find_by(id: id_of_the_recipe)
    case element_to_change
    when "name"
    recipe.update(name: new_element)
    when "desription"
    recipe.update(description: new_element)
    end
  when 5
    puts "which recipe would you like to delete ? Type its number"
    Recipe.all.each do |recipe|
      puts "#{recipe.id}. #{recipe.name} #{recipe.description} #{recipe.length} #{recipe.difficulty}"
    end
    id_of_the_recipe = gets.chomp.to_i
    Recipe.find_by(id: id_of_the_recipe).destroy
  when 6
    puts "bye bye"
  else
    puts "i did not understand"
    
  end
end
