require 'sqlite3'

# opens the database
database_path = "db/jukebox.sqlite"
db = SQLite3::Database.new(database_path)

# 1. returns the list of tracks with their album and artist
tracks = db.execute ( "SELECT Artist.Name, Album.Title, Track.Name
	FROM Artist
	INNER JOIN Track 
	on Track.AlbumId = Album.AlbumId
	INNER JOIN Album 
	on Album.ArtistId = Artist.ArtistId " ) 
tracks.each { |line| puts "*** #{line}" }


# 2. For each genre of music, finds the number of tracks and the average song length.
# your code here.

genre_study = db.execute ( "SELECT Genre.Name, COUNT(Track.Name), AVG(Track.Milliseconds)
	FROM Genre
	INNER JOIN Track
	on Genre.GenreId = Track.GenreId
	GROUP BY Genre.Name" ) do |row|
puts "#{row[0]} #{row[1]} tracks #{(row[2]/60000).round(2)} minutes of average time"
end

# 3. List the top 5 rock artists
# your code here.

top_rock_artists = db.execute ( "SELECT Artist.Name
	, COUNT(Track.TrackID)
	FROM Track
	INNER JOIN Album
	on Album.AlbumId = Track.AlbumId
	INNER JOIN Artist
	on Album.ArtistId = Artist.ArtistId
	INNER JOIN Genre
	on Genre.GenreID = Track.GenreId
	WHERE Genre.Name == 'Rock'
	GROUP BY Artist.Name
	ORDER BY COUNT(Track.TrackID) DESC limit 5" )
puts top_rock_artists


# sql = " SELECT a.name, count(t.trackId) FROM Track t inner join Album b on t.albumId = b.albumId "
# sql += " inner join Artist a on a.artistId = b.artistId "
# sql += " inner join Genre g on g.genreId = t.genreId "
# sql += " where g.name == 'Rock'  group by a.name order by count(t.trackId) DESC limit 5"
# top_artists = db.execute(sql)
# puts top_artists