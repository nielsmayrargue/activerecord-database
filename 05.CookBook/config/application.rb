#Fichier de config de la DB. Peut aussi contenir configs portant sur d'autres éléments : gems modifiées, clés secretes d'API...
#Fait appel au fichier yml qui spécifie certaines modalités des relations entre Active Record et la DB

require 'sqlite3'
require 'active_record'

ActiveRecord::Base.configurations = YAML::load(IO.read(File.join(File.dirname(__FILE__),'database.yml'))) #dit où se trouve le fichier de conf
ActiveRecord::Base.establish_connection('development') #utilise le fichier de conf


# Migrations
# Create the migration for the Recipe table
unless ActiveRecord::Base.connection.tables.include? "recipes"
  ActiveRecord::Schema.define do
    create_table :recipes do |t|
    	t.text :name
    	t.text :description
    	t.integer :length
    	t.integer :difficulty       
    end
  end
end