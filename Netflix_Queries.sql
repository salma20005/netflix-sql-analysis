select * from 
netflix_titles
-- Netflix Data Analysis using SQL
-- 1. Count the number of Movies vs TV Shows
select type, count(*) as total_movies
from netflix_titles
group by type

-- 2. Find the most common rating for movies and TV shows
with most_common as (
select type, rating, count(*) as common_ratings,
rank() over(partition by type order by count(*) DESC ) rn
from netflix_titles
group by type , rating
)
select *
from most_common
where rn = 1 

-- another solution
WITH RatingCounts AS (
    SELECT 
        type,
        rating,
        COUNT(*) AS rating_count
    FROM netflix_titles
    GROUP BY type, rating
),
RankedRatings AS (
    SELECT 
        type,
        rating,
        rating_count,
        RANK() OVER (PARTITION BY type ORDER BY rating_count DESC) AS rank
    FROM RatingCounts
)
SELECT 
    type,
    rating AS most_frequent_rating
FROM RankedRatings
WHERE rank = 1;

-- 3.List all movies released in a specific year (e.g., 2020)
select *
from netflix_titles
where release_year = 2020

-- 4. Find the top 5 countries with the most content on Netflix
SELECT TOP 5 TRIM(value) AS country, COUNT(*) AS total_content
FROM netflix_titles
-- CROSS APPLY is used to apply the STRING_SPLIT function to each row in the table.
-- It takes the 'country' column (which may contain multiple values separated by commas)
-- and splits it into multiple rows, one country per row.
-- This allows us to treat each country as a separate value for accurate counting and grouping.
CROSS APPLY STRING_SPLIT(country, ',')
WHERE country IS NOT NULL
GROUP BY TRIM(value)
ORDER BY total_content DESC;

-- 5. Identify the longest movie
select top 1 title , CAST(LEFT(duration, CHARINDEX(' ', duration) - 1) AS INT) as movie_duration
from netflix_titles
where type ='Movie'and LEFT(duration, CHARINDEX(' ', duration) - 1) IS NOT NULL
order by movie_duration DESC 

-- 6. Find content added in the last 5 years
select *
from netflix_titles 
where date_added >= DATEADD(YEAR, -5,    (SELECT MAX(date_added) FROM netflix_titles))

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!
select title
from netflix_titles
CROSS APPLY STRING_SPLIT(director, ',')
WHERE LTRIM(RTRIM(value)) = 'Rajiv Chilaka';


-- 8. List all TV shows with more than 5 seasons
select title, duration
from netflix_titles
where  left(duration , CHARINDEX(' ' ,duration) - 1) > 5
and type = 'TV Show'

-- 9. Count the number of content items in each genre
select trim(value) as Genre , count(*) as total_contents
from netflix_titles
cross apply string_split(listed_in,',')
group by trim(value)

-- 10. Find each year and the average numbers of content release by India on netflix. 
-- return top 5 year with highest avg content release !
SELECT TOP 5
    release_year,
    COUNT(*) AS total_content
FROM netflix_titles
WHERE country LIKE '%India%'
GROUP BY release_year
ORDER BY total_content DESC;

-- 11. List all movies that are documentaries
select *
from netflix_titles
where type = 'Movie' and listed_in like '%Documentaries%'

-- 12. Find all content without a director
select *
from netflix_titles
where director is null

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!
select count(*) as salman_khan_movies
from netflix_titles
where cast like '%Salman Khan%'
and release_year >=  (select max(release_year) from netflix_titles) - 10

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.
select TOP 10 trim(value) as Actor, count(*) as Total_movies
from netflix_titles
cross apply string_split(cast,',')
where country = 'India' and type ='Movie'
group by trim(value)
order by count(*) DESC

/*
Question 15:
Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.
*/
with cte as(
select * , 
CASE WHEN lower(description) like '%Kill%' or lower(description) like '%Violence%' THEN 'Bad'
  ELSE 'Good'
  END as movie_category
from netflix_titles
)
select movie_category, count(*) as category_count
from cte
group by movie_category
