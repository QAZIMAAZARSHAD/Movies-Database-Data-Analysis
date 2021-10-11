CREATE DATABASE movies;

USE movies;

CREATE TABLE films (
  id                    INTEGER,     
  title                 VARCHAR(50),
  release_year          INTEGER,
  country               VARCHAR(30),
  duration              INTEGER,
  language              VARCHAR(30),
  certification         VARCHAR(25),
  gross                 BIGINT,
  budget                BIGINT,
  CONSTRAINT films_pk PRIMARY KEY(id)
);

CREATE TABLE people (
  id                    INTEGER     PRIMARY KEY,
  name                  VARCHAR(30),
  birthdate             DATE,
  deathdate             DATE
);

CREATE TABLE reviews (
  id                    INTEGER     PRIMARY KEY,
  film_id               INTEGER,
  num_user              INTEGER,
  num_critic            INTEGER,
  imdb_score            REAL,
  num_votes             INTEGER,
  facebook_likes        INTEGER
);

CREATE TABLE roles (
  id                    INTEGER     PRIMARY KEY,
  film_id               INTEGER,
  person_id             INTEGER,
  role                  VARCHAR(30)
);

-- Show All tables
SHOW TABLES;
-- Show content of films table
SELECT * FROM films;
-- Show content of people table
SELECT * FROM people;
-- Show content of reviews table
SELECT * FROM reviews;
-- Show content of roles table
SELECT * FROM roles;

-- Selecting Columns: SELECT, SELECT DISTINCT

-- Get the title of every film
SELECT title
FROM films;
-- Get all details for every film
SELECT *
FROM films;
-- Get the names of everyone involved in working on the films
SELECT name
FROM people;
-- Get the title and release year of every film
SELECT title, release_year
FROM films;
-- Get the title, release year and country for every film
SELECT title, release_year, country
FROM films;
-- Get every person's name and their date of birth where possible
SELECT name, birthdate
FROM people;
-- Get every person name and their date of death where possible
SELECT name, deathdate
FROM people;
-- Get everyone's name, date of birth, and date of death (where possible)
SELECT name, birthdate, deathdate
FROM people;
-- Get all the different countries
SELECT DISTINCT country
FROM films;
-- Get all the different film languages
SELECT DISTINCT language
FROM films;
-- Get the different types of film roles
SELECT DISTINCT role
FROM roles;
-- Get all the different certification categories
SELECT DISTINCT certification
FROM films;
-- Get all the different IMDB scores
SELECT DISTINCT imdb_score
FROM reviews;

-- Aggregate Functions: COUNT, SUM, AVG, MIN, MAX

-- Count the number of rows in the people table
SELECT COUNT(*)
FROM people;
-- Result 781
-- Count the number of birthdate entries in the people table
SELECT COUNT(birthdate)
FROM people;
-- Result 781
-- Count the number of unique birthdate entries in the people table
SELECT COUNT(DISTINCT birthdate)
FROM people;
-- Result 757
-- Count the number of unique languages
SELECT COUNT(DISTINCT language)
FROM films;
-- Result 39
-- Count the number of unique countries
SELECT COUNT(DISTINCT country)
FROM films;
-- Result 46
-- Count the number of people who have died
SELECT COUNT(deathdate)
FROM people;
-- Result 781
-- Count the number of years the dataset covers
SELECT COUNT(DISTINCT release_year)
FROM films;
-- Result 75
-- Get the total duration of all films
SELECT SUM(duration)
FROM films;
-- Result 426426
-- Get the average duration of all films
SELECT AVG(duration)
FROM films;
-- Result 109.9319
-- Get the duration of the shortest film
SELECT MIN(duration)
FROM films;
-- Result 37
-- Get the amount made by the highest grossing film
SELECT MAX(gross)
FROM films;
-- Result 936627416
-- Get the amount made by the lowest grossing film
SELECT MIN(gross)
From films;
-- Result 162
-- Get both the lowest and highest grossing films, for comparision
SELECT MIN(gross), MAX(gross)
FROM films;
-- Get the highest number of Facebook likes for any film
SELECT MAX(facebook_likes)
FROM reviews;
-- Result 150000

-- Aliasing and Basic Arithmetic

-- Get the profit (or loss) for each movie, where possible
SELECT title, gross - budget
AS profit_or_loss
FROM films;
-- Get the duration in hours for each film
SELECT title, duration / 60.0 AS duration_hours
FROM films;
-- Get the average film duration in hours
SELECT AVG(duration) / 60.0
AS duration_hours  
FROM films;
-- Result 1.83219902
-- Get the percentage of people who have died
SELECT COUNT(deathdate) * 100 / COUNT(*)
AS percentage_dead
FROM people;
-- Result 100.0000
-- Check if there's an even number of unique languages
SELECT COUNT(DISTINCT language) % 2
AS result
FROM films;
-- Result 1 (0 = yes, 1 = no)
-- Get the of years between the oldest film and newest film
SELECT MAX(release_year) - MIN(release_year)
AS difference
FROM films;
-- Result 96
-- Get the number of decades this dataset covers
SELECT (MAX(release_year) - MIN(release_year)) / 10
AS number_of_decades
FROM films;
-- Result 9.6000

-- Rounding Functions: ROUND, FLOOR, CEILING

-- Get the average duration of all films, rounded to the nearest minute
SELECT ROUND(AVG(duration))
AS rounded_avg_run_time
FROM films;
-- Result 110
-- Get the average duration of all films, rounded down to nearest minute
SELECT FLOOR(AVG(duration))
AS floored_avg_run_time
FROM films;
-- Result 109
-- Get the average duration of all films, rounded up to the nearest minute
SELECT CEILING(AVG(duration))
FROM films;
-- Result 110

-- Filtering: WHERE, =, <>, <, <=, >, >=, AND, OR

-- Get all French language films
SELECT *
FROM films
WHERE language = 'French';
-- Get the number of Hindi movies
SELECT COUNT(*)
FROM films
WHERE language = 'Hindi';
-- Result 10
-- Get all movies with an R certification
SELECT *
FROM films
WHERE certification = 'R';
-- Get all films released in 2016
SELECT *
FROM films
WHERE release_year = 2016;
-- Count of actors
SELECT COUNT(*)
FROM roles
WHERE role = 'actor';
-- Result 14862
-- Count of directors
SELECT COUNT(*)
FROM roles
WHERE role = 'director';
-- Result 4929
-- Count of movies not rated
SELECT COUNT(*)
FROM films
WHERE certification = 'Not Rated' OR certification IS NULL;
-- Result 42
-- Count of movies not in English
SELECT COUNT(*)
FROM films
WHERE language <> 'English';
-- Result 184
-- Get the number of films released before 2000
SELECT COUNT(*)
FROM films
WHERE release_year < 2000;
-- Result 1050
-- Get the title and release year of films released since 2000
SELECT title, release_year
FROM films
WHERE release_year > 2000;
-- Get all Spanish films released before 2000
SELECT title, release_year
FROM films
WHERE release_year < 2000
AND language = 'Spanish';
-- Get the all Spanish films released since 2000
SELECT *
FROM films
WHERE release_year > 2000
AND language = 'Spanish';
-- Get average duration for films released in France in 1993
SELECT AVG(duration)
FROM films
WHERE release_year = 1993
AND country = 'France';
-- Result 103.0000
-- Get films released in 1990 or released in 2000 in French or Spanish
SELECT title, release_year
FROM films
WHERE release_year = 1990 OR release_year = 2000
AND language = 'French' OR language = 'Spanish';
-- Get films released since 2000 that are in French or Spanish, and made more than $20m
SELECT *
FROM films
WHERE release_year > 2000
AND language = 'French' OR language = 'Spanish'
AND gross > 20000000;
-- Get films released in the 90s
SELECT title, release_year
FROM films
WHERE release_year >= 1990 AND release_year <= 2000;
-- Get average duration for films released in the UK or which were released in 2012
SELECT AVG(duration)
FROM films
AS average_duration
WHERE release_year = 2012
OR COUNTRY = 'UK';
-- Result 111.3194

-- Advanced Filtering: BETWEEN, IN, IS NULL, IS NOT NULL, LIKE, NOT LIKE

-- Get films released in the 90s
SELECT title, release_year
FROM films
WHERE release_year BETWEEN 1990 AND 2000;
-- Get the number of films released in the 90s
SELECT COUNT(*)
FROM films
WHERE release_year BETWEEN 1990 AND 2000;
-- Result 111.3194
-- Get the number of films made between 2000 and 2015 with budgets over $100 million
SELECT title, budget
FROM films
WHERE release_year
BETWEEN 2000 AND 2015
AND budget > 100000000;
-- Get films released in in 1990 or released in 2000 that were longer than two hours
SELECT title, release_year
FROM films
WHERE release_year IN (1990, 2000)
AND duration > 120;
-- Get the number of films released between 2000 and 2015 that were longer than two hours
SELECT COUNT(*)
FROM films
WHERE release_year BETWEEN 2000 AND 2015
AND duration > 120;
-- Result 587
-- Get the names of people who are still alive
SELECT name
FROM people
WHERE deathdate IS NULL OR deathdate = '';
-- Get people whose names begin with 'B'
SELECT name
FROM people
WHERE name LIKE 'B%';
-- Get people whose names begin with 'Br'
SELECT name
FROM people
WHERE name LIKE 'Br%';
-- Get people whose names have 'r' as the second letter
SELECT name
FROM people
WHERE name LIKE '_r%';
-- Get people whose names don't start with A
SELECT name
FROM people
WHERE name NOT LIKE 'A%';

-- Sorting and Grouping

-- Get people, sort by name
SELECT name
FROM people ORDER BY name;
-- Get people, in order of when they were born
SELECT birthdate, name
FROM people
ORDER BY birthdate;
-- Get films released in 2000 or 2015, in the order they were released
SELECT title, release_year
FROM films
WHERE release_year in (2000, 2015)
ORDER BY release_year;
-- Get all films except those released in 2015, order them so we can see results
SELECT *
FROM films
WHERE release_year <> 2015
ORDER BY release_year;
-- Get the score and film id for every film, from highest to lowest
SELECT imdb_score, film_id
FROM reviews
ORDER BY imdb_score DESC;
-- Get the titles of films in reverse order
SELECT *
FROM films
ORDER BY title DESC;
-- Get people, in order of when they were born, and alphabetical order
SELECT birthdate, name
FROM people
ORDER BY birthdate, name;
-- Get films from in 2000 or 2015, sorted in the order they were released, and how long they were
SELECT release_year, duration, title
FROM films
WHERE release_year IN (2000, 2015)
ORDER BY release_year, duration;
-- Get films between 2000 and 2015, sorted by certification and the year they were released
SELECT certification, release_year, title
FROM films
WHERE release_year IN (2000, 2015)
ORDER BY certification, release_year;
-- Get people whose names start with A, B or C, (redundantly) ordered
SELECT name, birthdate
FROM people
WHERE name LIKE 'A%' OR name LIKE 'B%' OR name LIKE 'C%'
ORDER BY birthdate;
-- Get count of films made in each year
SELECT release_year, COUNT(release_year)
FROM films
GROUP BY release_year;
-- Get count of films, group by release year then order by release year
SELECT release_year, COUNT(title) as films_released
FROM films
GROUP BY release_year
ORDER BY release_year;
-- Get count of films released in each year, ordered by count, lowest to highest
SELECT release_year, COUNT(title) AS films_released
FROM films
GROUP BY release_year
ORDER BY films_released;
-- Get count of films released in each year, ordered by count highest to lowest
SELECT release_year, COUNT(title) AS films_released
FROM films
GROUP BY release_year
ORDER BY films_released DESC;
-- Get lowest box office earnings per year
SELECT release_year, MIN(gross)
FROM films
GROUP BY release_year
ORDER BY release_year;
-- Get the total amount made in each language
SELECT language, SUM(gross)
FROM films
GROUP BY language;
-- Get the total amount spent by each country
SELECT country, SUM(gross)
FROM films
GROUP BY country;
-- Get the most spent making film for each year, for each country
SELECT release_year, country, MAX(budget)
FROM films
GROUP BY release_year, country
ORDER BY release_year, country;
-- Get the lowest box office made by each country in each year
SELECT release_year, country, MIN(gross)
FROM films
GROUP BY release_year, country
ORDER BY release_year, country;
-- Get the rounded average budget and average box office earnings for movies since 1990, but only 
-- if the average budget was greater than $60m in that year
SELECT release_year, ROUND(AVG(budget)) AS avg_budget, ROUND(AVG(gross)) AS avg_box_office
FROM films
WHERE release_year > 1990
GROUP BY release_year
HAVING AVG(budget) > 20000000
ORDER BY release_year DESC;
-- Get the name, average budget, average box office take of countries who have made more than 10 films.
-- Order by name, and get the top five
SELECT country, ROUND(AVG(budget)) AS avg_budget, ROUND(AVG(gross)) AS avg_box_office
FROM films
GROUP BY country
HAVING COUNT(title) > 10
ORDER BY country
LIMIT 5;
-- Get the average amount made by each country
SELECT country, AVG(gross)
FROM films
GROUP BY country;
-- Get rounded average box office earnings per year
SELECT release_year, ROUND(AVG(gross))
FROM films
GROUP BY release_year
ORDER BY release_year;
-- Get lowest and highest box office earnings per year
SELECT release_year, MIN(gross), MAX(gross)
FROM films
GROUP BY release_year
ORDER BY release_year DESC;
-- Get the highest box office take per country
SELECT country, MAX(gross)
FROM films
GROUP BY country;
-- Longest duration per year
SELECT release_year, MAX(duration) AS max_duration
FROM films
GROUP BY release_year
ORDER BY max_duration DESC;

-- Subqueries

-- Get the title, duration and release year of the shortest film(s)
SELECT title, duration, release_year
FROM films
WHERE duration = (
  SELECT MIN(duration) FROM films
);
-- Get the title, duration and release year of the longest film(s)
SELECT title, duration, release_year
FROM films
WHERE duration = (
  SELECT MAX(duration)
  FROM films
);
-- Get the title, release_year and box office take for the highest grossing film
SELECT title, release_year, gross
FROM films
WHERE gross = (
  SELECT MAX(gross)
  FROM films
);
-- Get the title, release_year and box office take for the lowest grossing film
SELECT title, release_year, gross
FROM films
WHERE gross = (
  SELECT MIN(gross)
  FROM films
);
-- Get the duration of the longest movie made in the USA
SELECT title, duration
FROM films
WHERE duration = (
  SELECT MAX(duration)
  FROM films
  WHERE country = 'USA'
);
-- Get details for the film with the lowest box office earnings per year
SELECT release_year, title, gross
FROM films
WHERE release_year IN (
  SELECT release_year
  FROM films
  WHERE gross IN (
    SELECT MIN(gross)
    FROM films
    GROUP BY release_year
  )
);
-- Get details for the film with the highest box office earnings per year
SELECT release_year, title, gross
FROM films
WHERE release_year IN (
  SELECT release_year
  FROM films
  WHERE gross IN (
    SELECT MAX(gross)
    FROM films
    GROUP BY release_year
  )
);

-- Joins

-- Get film id of films whose review exist
SELECT films.id
FROM films
INNER JOIN reviews
ON films.id = reviews.film_id;
-- 









