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

UPDATE animals SET species = 'digimon' WHERE name like '%mon';

UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

BEGIN TRANSACTION;
DELETE FROM animals;

ROLLBACK;

SELECT FROM animals;

BEGIN TRANSACTION;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT SV1;

UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO SV1;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

--count

SELECT COUNT(*) FROM animals; 

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;


SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN 'Jan 1, 1990' AND 'Dec 31, 2000' GROUP BY species;

-- multiple tables

-- What animals belong to Melody Pond?
SELECT name, full_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, species.name FROM animals JOIN species ON animals.species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name, name  FROM animals RIGHT JOIN owners ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name, COUNT(*) FROM animals JOIN species ON animals.species_id = species.id GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name, species.name, full_name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owner_id = owners.id WHERE species.name = 'Digimon' AND full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester with 0 escape attempts.
SELECT animals.name, full_name, escape_attempts FROM animals JOIN owners ON animals.owner_id = owners.id WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;

-- Who owns the most animals?
SELECT full_name, COUNT(*) as most_animals FROM animals JOIN owners ON animals.owner_id = owners.id GROUP BY full_name ORDER BY COUNT(*) DESC LIMIT 1;

-- add-join

SELECT A.name, vets.name, V.date
FROM visits V
JOIN animals A
ON V.animal_id = A.id
JOIN vets
ON V.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY V.date DESC LIMIT 1;

SELECT V.name, COUNT(animals.id) AS "NUMBER OF ANIMALS"
FROM visits
JOIN animals
ON visits.animal_id = animals.id
JOIN vets V
ON visits.vet_id = V.id
WHERE V.name = 'Stephanie Mendez'
GROUP BY V.name;

SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations
ON vets.id = specializations.vet_id
LEFT JOIN species
ON specializations.species_id = species.id;

SELECT vets.name, animals.name, visits.date
FROM animals
JOIN visits
ON visits.animal_id = animals.id
JOIN vets
ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' AND visits.date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT COUNT(visits.animal_id) AS VISITS
FROM animals
JOIN visits
ON animals.id = visits.animal_id
GROUP BY animals.id
ORDER BY VISITS DESC LIMIT 1;

SELECT A.name, vets.name, V.date
FROM visits V
JOIN animals A
ON V.animal_id = A.id
JOIN vets
ON V.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY V.date ASC LIMIT 1;

SELECT animals.* AS ANIMAL_INFORMATION, vets.* AS VET_INFORMATION, visits.date
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN vets
ON visits.vet_id = vets.id
ORDER BY visits.date DESC LIMIT 1;

SELECT COUNT(*) AS "VISITS TO VETS NOT SPECIALISED IN THAT SPECIES"
FROM visits
JOIN vets
ON visits.vet_id = vets.id
JOIN animals
ON visits.animal_id = animals.id
LEFT JOIN specializations
ON vets.id = specializations.vet_id AND animals.species_id = specializations.species_id
WHERE specializations.species_id IS NULL;

SELECT MAX(species.name) AS "SPECIES MAISY SMITH SHOULD CONSIDER"
FROM animals
JOIN visits
ON animals.id = visits.animal_id
JOIN species
ON animals.species_id = species.id
WHERE visits.vet_id = (SELECT id FROM vets WHERE name = 'Maisy Smith')
GROUP BY species.id ORDER BY COUNT(*) DESC LIMIT 1;
