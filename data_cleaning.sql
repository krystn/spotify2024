SELECT * 
FROM spotify_2024.`most streamed spotify songs 2024`;

-- STAGING
CREATE TABLE spotify_staging
LIKE spotify_2024.`most streamed spotify songs 2024`;

SELECT *
FROM spotify_staging;

INSERT spotify_staging
SELECT *
FROM spotify_2024.`most streamed spotify songs 2024`;

-- CHECK FOR DUPLICATES
SELECT Track, Artist, COUNT(*)
FROM spotify_staging
GROUP BY Track, Artist
HAVING COUNT(*) > 1;

-- STANDARDIZE DATA
-- Remove leading or trailing spaces
SELECT *
FROM spotify_staging;

SELECT Track, TRIM(Track)
FROM spotify_staging;

UPDATE spotify_staging
SET Track = TRIM(Track);

SELECT `Album Name`, TRIM(`Album Name`)
FROM spotify_staging;

UPDATE spotify_staging
SET `Album Name` = TRIM(`Album Name`);

SELECT Artist, TRIM(Artist)
FROM spotify_staging;

UPDATE spotify_staging
SET Artist = TRIM(Artist);

SELECT DISTINCT Artist
FROM spotify_staging
ORDER BY 1;

-- Change Date to Date data type
SELECT *
FROM spotify_staging;

SELECT `Release Date`
FROM spotify_staging
ORDER BY 1;

UPDATE spotify_staging
SET `Release Date` = STR_TO_DATE(`Release Date`, '%m/%d/%Y');

-- change data type for date column to DATE
ALTER TABLE spotify_staging
MODIFY COLUMN `Release Date` DATE;

-- Remove commas from number strings
UPDATE spotify_staging 
SET `Spotify Streams` = REPLACE(`Spotify Streams`, ',', '');

UPDATE spotify_staging 
SET `Spotify Playlist Count` = REPLACE(`Spotify Playlist Count`, ',', '');

UPDATE spotify_staging 
SET `Spotify Playlist Reach` = REPLACE(`Spotify Playlist Reach`, ',', '');

-- Change data type from string to int or bigint
ALTER TABLE spotify_staging
MODIFY COLUMN `Spotify Streams` BIGINT;

ALTER TABLE spotify_staging
MODIFY COLUMN `Spotify Playlist Count` INT;

ALTER TABLE spotify_staging
MODIFY COLUMN `Spotify Playlist Reach` INT;

-- Dropping columns I will not be analyzing for now
CREATE TABLE spotify_staging2
LIKE spotify_staging;

SELECT *
FROM spotify_staging2;

INSERT spotify_staging2
SELECT *
FROM spotify_staging;

-- Drop columns that aren't spotify related
ALTER TABLE spotify_staging2
DROP COLUMN `YouTube Views`, 
DROP COLUMN `YouTube Likes`, 
DROP COLUMN `TikTok Posts`, 
DROP COLUMN `TikTok Likes`, 
DROP COLUMN `TikTok Views`, 
DROP COLUMN `YouTube Playlist Reach`, 
DROP COLUMN `Apple Music Playlist Count`, 
DROP COLUMN `AirPlay Spins`, 
DROP COLUMN `SiriusXM Spins`, 
DROP COLUMN `Deezer Playlist Count`, 
DROP COLUMN `Deezer Playlist Reach`, 
DROP COLUMN `Amazon Playlist Count`,
DROP COLUMN `Pandora Streams`, 
DROP COLUMN `Pandora Track Stations`, 
DROP COLUMN `Soundcloud Streams`, 
DROP COLUMN `Shazam Counts`, 
DROP COLUMN `TIDAL Popularity`;