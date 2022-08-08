
CREATE TABLE IF NOT EXISTS Artists (
	id SERIAL PRIMARY KEY,
	name VARCHAR(80) NOT NULL
);

CREATE TABLE IF NOT EXISTS Genres (
	id SERIAL PRIMARY KEY,
	name VARCHAR(80) NOT NULL
);

CREATE TABLE IF NOT EXISTS Albums (
	id SERIAL PRIMARY KEY,
	name VARCHAR(80) NOT NULL,
        year INTEGER NOT NULL CHECK(year>0)
);

CREATE TABLE IF NOT EXISTS Collections (
	id SERIAL PRIMARY KEY,
	name VARCHAR(80) NOT NULL,
        year INTEGER NOT NULL CHECK(year>0)
);

CREATE TABLE IF NOT EXISTS Trecks (
	id SERIAL PRIMARY KEY,
	name VARCHAR(80) NOT NULL,
        duration NUMERIC(3,2) NOT NULL,
        album_id INTEGER REFERENCES Albums(id)
);

CREATE TABLE IF NOT EXISTS GenreArtist (
	genre_id INTEGER REFERENCES Genres(id),
	artist_id INTEGER REFERENCES Artists(id),
	CONSTRAINT PK_GenreArtist PRIMARY KEY (genre_id, artist_id)
);

CREATE TABLE IF NOT EXISTS ArtistAlbum (
	album_id INTEGER REFERENCES Albums(id),
	artist_id INTEGER REFERENCES Artists(id),
	CONSTRAINT PK_ArtistAlbum PRIMARY KEY (album_id, artist_id)
);

CREATE TABLE IF NOT EXISTS CollectionTreck (
	collection_id INTEGER REFERENCES Collections(id),
	treck_id INTEGER REFERENCES Trecks(id),
	CONSTRAINT PK_CollectionTreck PRIMARY KEY (collection_id, treck_id)
);




