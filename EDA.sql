-- Exploratory Data Analysis
SELECT *
FROM spotify_staging2;


-- ARTIST INSIGHTS
-- Top 10 artists with the most tracks
SELECT Artist, COUNT(*) AS artist_count
FROM spotify_staging2
GROUP BY Artist
ORDER BY artist_count DESC
LIMIT 10;

-- Top 10 artists by total streams
SELECT Artist, SUM(`Track Score`) AS total_streams
FROM spotify_staging2
GROUP BY Artist
ORDER BY total_streams DESC
LIMIT 10;

-- Top 10 artist by average track score
SELECT Artist, AVG(`Track Score`) AS avg_track_score
FROM spotify_staging2
GROUP BY Artist
ORDER BY avg_track_score DESC
LIMIT 10;


-- TRACK POPULARITY & PERFORMANCE
-- 10 songs placed in the most playlist
SELECT Track, Artist, `Spotify Playlist Count`
FROM spotify_staging2
ORDER BY `Spotify Playlist Count` DESC
LIMIT 10;

-- Top 10 tracks by spotify popularity
SELECT Track, Artist, `Spotify Popularity`
FROM spotify_staging2
ORDER BY `Spotify Popularity` DESC
LIMIT 10;

-- Number of explicit and clean tracks
SELECT `Explicit Track`, COUNT(*) AS Count_Explicit
FROM spotify_staging2
GROUP BY `Explicit Track`
ORDER BY 2 DESC;

-- Percent of explicit and clean tracks
SELECT 
  (SUM(`Explicit Track` = 1) / COUNT(*)) * 100 AS explicit_percentage,
  (SUM(`Explicit Track` = 0) / COUNT(*)) * 100 AS clean_percentage
FROM spotify_staging2;

-- Percent of explicit and clean tracks by year
SELECT YEAR(`Release Date`) AS release_year,
  (SUM(`Explicit Track` = 1) / COUNT(*)) * 100 AS explicit_percentage,
  (SUM(`Explicit Track` = 0) / COUNT(*)) * 100 AS clean_percentage
FROM spotify_staging2
GROUP BY release_year
ORDER BY 1 DESC;

-- Most streamed tracks with low popularity score
SELECT Track, Artist, `Spotify Streams`, `Spotify Popularity`
FROM spotify_staging2
WHERE `Spotify Popularity` < 50
ORDER BY `Spotify Streams` DESC
LIMIT 10;

-- Top 10 tracks with high playlist count but low reach
SELECT Track, Artist, `Spotify Playlist Count`, `Spotify Playlist Reach`
FROM spotify_staging2
WHERE `Spotify Playlist Count` > 100000  AND `Spotify Playlist Reach` < 25000000
ORDER BY `Spotify Playlist Count` DESC
LIMIT 10;

-- Top 10 Albums with the most tracks in top 1000
SELECT `Album Name`, COUNT(*) AS Album_Track_Count
FROM spotify_staging2
GROUP BY `Album Name`
ORDER BY 2 DESC
LIMIT 10;


-- TRENDS OVER TIME
-- Number of tracks released per year
SELECT YEAR(`Release Date`) AS Release_Year, COUNT(*) AS Track_Count
FROM spotify_staging2
GROUP BY Release_Year
ORDER BY 1 DESC;

-- Number of tracks released by month
SELECT MONTHNAME(`Release Date`) AS Release_Month, COUNT(*) AS Track_Count
FROM spotify_staging2
GROUP BY Release_Month
ORDER BY FIELD(Release_Month, 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');

-- Number of tracks released by weekday
SELECT 
  DAYNAME(`Release Date`) AS weekday,
  COUNT(*) AS track_count
FROM spotify_staging2
GROUP BY weekday
ORDER BY FIELD(weekday, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');

-- Release weekday and month of tracks with highest popularity
SELECT Track, Artist, DAYNAME(`Release Date`) AS weekday, MONTHNAME(`Release Date`) AS Release_Month
FROM spotify_staging2
ORDER BY `Spotify Popularity` DESC
LIMIT 10;
