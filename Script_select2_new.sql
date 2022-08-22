-- 1 - количество исполнителей в каждом жанре
SELECT g.name, COUNT(artist_id) FROM genreartist ga
LEFT JOIN genres g ON ga.genre_id = g.id
GROUP BY g.name;
 
-- 2 - количество треков, вошедших в альбомы 2019-2020 годов;
SELECT a.name альбом, COUNT(t.album_id) треков FROM trecks t
LEFT JOIN albums a ON t.album_id = a.id
WHERE a.year >= 2018 AND a.year <= 2020
GROUP BY a.name;
 
-- 3 - средняя продолжительность треков по каждому альбому;
SELECT a.name альбом, AVG(t.duration) продолжит FROM trecks t
LEFT JOIN albums a ON t.album_id = a.id
GROUP BY a.name;
 
-- 4 - все исполнители, которые не выпустили альбомы в 2020 году;
/*
Замечание:
реализация 4 запроса отвечает на вопрос “кто выпустил хоть что-то, кроме того, что выпустил в 2020”, 
а не на вопрос: “кто не выпустил альбомы в 2020 году”. Чтобы решить поставленную задачу нужно сначала 
найти тех, кто выпустил альбом в 2020, а потом их исключить из общего списка исполнителей. 
Тут оптимальнее было использовать вложенный запрос.
*/
   SELECT ar.name FROM artists ar
    WHERE ar.name NOT IN (
   SELECT ar.name FROM artists ar
     JOIN artistalbum aa ON ar.id = aa.artist_id
LEFT JOIN albums a ON aa.artist_id = a.id
    WHERE a.year = 2020);
 
-- 5 - названия сборников, в которых присутствует конкретный исполнитель (выберите сами);
/*
 зачем в 5 запросе группировка, когда там вообще нет никаких агрегирующих функций. Это просто лишнее действие. 
 Если вы хотели оставить только уникальные записи в выводе, то стоило использовать DISTINCT. Аналогично в 8 запросе.
 */
SELECT DISTINCT c.name FROM collections c 
  JOIN collectiontreck ct ON ct.collection_id = c.id
  JOIN trecks t ON ct.treck_id = t.id
  JOIN albums a ON t.album_id = a.id
  JOIN artistalbum aa ON aa.album_id = aa.artist_id
  JOIN artists ar ON aa.artist_id = ar.id
 WHERE ar.name LIKE 'Ann Minogue';

-- 6 - название альбомов, в которых присутствуют исполнители более 1 жанра;
SELECT a.name альбом FROM genres g 
JOIN genreartist ga ON ga.genre_id = g.id
JOIN artists ar ON ga.artist_id = ar.id
JOIN artistalbum aa ON aa.artist_id = ar.id
JOIN albums a ON aa.album_id = a.id
GROUP BY a.name
HAVING COUNT(g.name) > 1
ORDER BY a.name;
 
-- 7 - наименование треков, которые не входят в сборники;
SELECT t.name трек FROM trecks t
LEFT JOIN collectiontreck ct ON t.id = ct.treck_id
WHERE ct.treck_id IS NULL;
  
-- 8 - исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько);
/*
 Аналогично в 8 запросе. зачем группировка, когда там вообще нет никаких агрегирующих функций. Это просто лишнее действие. 
 Если вы хотели оставить только уникальные записи в выводе, то стоило использовать DISTINCT. 
 */
SELECT DISTINCT ar.name артист FROM trecks t 
  JOIN albums a ON t.album_id = a.id
  JOIN artistalbum aa ON a.id = aa.album_id
  JOIN artists ar ON aa.artist_id = ar.id
 WHERE t.duration = (SELECT MIN(duration) FROM trecks);
 
-- 9 - название альбомов, содержащих наименьшее количество треков.
/*
Замечание:
И в 9 запросе нужно выводить только альбомы с минимальным количеством треков 
(а не все по убыванию количества).
*/
  SELECT a.name albumsname FROM albums a 
    JOIN trecks t on t.album_id = a.id
GROUP BY a.name
  HAVING count(t.name) = (
  SELECT min(alb.trecknum) from ( 
  SELECT a.name album, COUNT(t.name) trecknum FROM albums a 
    JOIN trecks t on t.album_id = a.id
GROUP BY a.name) as alb
);

*/
Только в последнем запросе можно было обойтись одним уровнем вложенности 
(названия полей и таблиц мои, но суть не меняется):

  SELECT Album.Title Album, COUNT(Track.Title) Track_count FROM Album 
    JOIN Track ON Album.Id = Track.AlbumId
GROUP BY Album.Title
  HAVING COUNT(Track.Title) = (  
  SELECT COUNT(Track.Title) FROM Album
    JOIN Track ON Album.Id = Track.AlbumId
GROUP BY Album.Title
ORDER BY COUNT(Track.Title)
   LIMIT 1);

Зачет!
*/




