require_relative 'config/application'
require './models/recipe'

# your code here to query the database
User.count

# finds all the recipes that contain
User.all.each do |user|
	puts "#{user.name} #{user.collection(force_reload = false)}"
end