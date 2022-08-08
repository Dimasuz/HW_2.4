-- количество исполнителей в каждом жанре
SELECT g.name, COUNT(artist_id) FROM genreartist ga
LEFT JOIN genres g ON ga.genre_id = g.id
GROUP BY g.name;
 
-- количество треков, вошедших в альбомы 2019-2020 годов;
SELECT a.name альбом, COUNT(t.album_id) треков FROM trecks t
LEFT JOIN albums a ON t.album_id = a.id
WHERE a.year >= 2018 AND a.year <= 2020
GROUP BY a.name;
 
-- средняя продолжительность треков по каждому альбому;
SELECT a.name альбом, AVG(t.duration) продолжит FROM trecks t
LEFT JOIN albums a ON t.album_id = a.id
GROUP BY a.name;
 
-- все исполнители, которые не выпустили альбомы в 2020 году;
SELECT ar.name FROM artists ar
JOIN artistalbum aa ON ar.id = aa.artist_id
LEFT JOIN albums a ON aa.artist_id = a.id
WHERE a.year <> 2020;
 
-- названия сборников, в которых присутствует конкретный исполнитель (выберите сами);
SELECT c.name FROM collections c 
JOIN collectiontreck ct ON ct.collection_id = c.id
JOIN trecks t ON ct.treck_id = t.id
JOIN albums a ON t.album_id = a.id
JOIN artistalbum aa ON aa.album_id = aa.artist_id
JOIN artists ar ON aa.artist_id = ar.id
WHERE ar.name LIKE 'The Beatles'
GROUP by c.name;
 
-- название альбомов, в которых присутствуют исполнители более 1 жанра;
SELECT a.name альбом FROM genres g 
JOIN genreartist ga ON ga.genre_id = g.id
JOIN artists ar ON ga.artist_id = ar.id
JOIN artistalbum aa ON aa.artist_id = ar.id
JOIN albums a ON aa.album_id = a.id
GROUP BY a.name
HAVING COUNT(g.name) > 1
ORDER BY a.name;
 
-- наименование треков, которые не входят в сборники;
SELECT t.name трек FROM trecks t
LEFT JOIN collectiontreck ct ON t.id = ct.treck_id
WHERE ct.treck_id IS NULL;
  
-- исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
SELECT ar.name артист FROM trecks t 
JOIN albums a ON t.album_id = a.id
JOIN artistalbum aa ON a.id = aa.album_id
JOIN artists ar ON aa.artist_id = ar.id
WHERE t.duration = (SELECT MIN(duration) FROM trecks)
GROUP BY ar.name;
 
-- название альбомов, содержащих наименьшее количество треков.
SELECT a.name альбом, COUNT(t.name) treck FROM albums a 
JOIN trecks t on t.album_id = a.id
GROUP BY a.name
ORDER BY treck;

