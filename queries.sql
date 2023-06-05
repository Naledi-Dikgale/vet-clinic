/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN 'Jan 1, 2016' AND 'Dec 31, 2019';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

--update

UPDATE table animals SET species = 'digimon' WHERE name like '%mon';

UPDATE table animals SET species = 'pokemon' WHERE species = null;

DELETE * FROM animals WHERE date_of_birth > '2022-01-01';

UPDATE * animals SET weight_kg * -1;

UPDATE * animals SET weight_kg * -1 WHERE weight_kg < 0;

--count

SELECT COUNT(*) FROM animals; 

SELECT COUNT(*) FROM animals WHERE escape_attempts =< 0;

SELECT AVG(weight_kg) FROM animals;

--WHO escapes the most, neutured or not neutered

SELECT escape_attempts, COUNT(*) FROM animals GROUP BY neutered = true GROUP BY neutered = false;

SELECT MIN(weight_kg) FROM animals WHERE species = 'pokemon' && species = 'digimon';

SELECT MAX(weight_kg) FROM animals WHERE species = 'pokemon' && species = 'digimon';

SELECT AVG(escape_attempts) FROM animals WHERE species = 'pokemon' && species = 'digimon' GROUP BY date_of_birth BETWEEN 'Jan 1, 1990' AND 'Dec 31, 2000';
