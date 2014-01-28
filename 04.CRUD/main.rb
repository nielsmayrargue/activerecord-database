require 'sqlite3'

# creates the database
db_path = "db/cookbook.sqlite"
db = SQLite3::Database.new(db_path)

# creates the schema of the database
# your code here
sql = 
  "CREATE TABLE IF NOT EXISTS Recipe(Id integer primary key autoincrement, Name TEXT,Description TEXT,Length INTEGER,Difficulty INTEGER)"

db.execute(sql)

#*************************************

# function to create a recipe
def create_recipe(db,name,description,length,difficulty)
  db.execute ( "INSERT INTO Recipe (Name,Description,Length,Difficulty) 
  	VALUES ('#{name}','#{description}',#{length},#{difficulty})")
end

# function to delete a recipe
def delete_recipe(db,id)
  db.execute ( "DELETE FROM Recipe WHERE Id = #{id}" )
end

# function to delete all recipes
def delete_all_recipes(db)
  db.execute ( "DELETE FROM Recipe" )
end

# function to update a recipe
def update_recipe(db,id,description)
  db.execute ( " UPDATE Recipe SET Id=#{id}, Description='#{description}'" )
end

def get_recipes(db)
	db.execute ( " CREATE VIEW IF NOT EXISTS view 
    AS SELECT *
    FROM Recipe ")
  return db.execute ( "SELECT * FROM view" )
end


#*************************************

# program

puts "Salut Robuchon, what do you want to do today?"
puts "1. create a recipe"
puts "2. delete all recipes"
puts "3. read your recipes"

choice =  gets.chomp.to_i

if choice == 1
  puts "Name ?"
  name = gets.chomp
  puts "description ?"
  description = gets.chomp
  puts "length ?"
  length = gets.chomp
  puts "difficulty ?"
  difficulty = gets.chomp
  create_recipe(db,name,description,length,difficulty)
  puts "your recipe has been saved !"
  # you need to ask for name, description, length and difficulty
  
elsif choice == 2
  delete_all_recipes(db)
  puts "your recipes have been deleted !"
  
elsif choice == 3
  print get_recipes(db)
end 



update_recipe(db,1,"lalala")
print get_recipes(db)
delete_recipe(db,1)
print get_recipes(db)




  
  
  
  
  
  
  