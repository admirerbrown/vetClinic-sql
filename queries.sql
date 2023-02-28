/*Queries that provide answers to the questions from all projects.*/

-- query when name ends with mon
SELECT * from animals WHERE name LIKE '%mon'; 
-- List the name of all animals born between 2016 and 2019.
SELECT * from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-01';
-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * from animals WHERE neutered = true AND escape_attempts < 3;
-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth, name FROM animals WHERE name LIKE 'Agumon' OR name = 'Pikachu';
-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT escape_attempts, name FROM animals WHERE weight_kg > 10.5;
-- Find all animals that are neutered.
SELECT * from animals WHERE neutered = true;
-- Find all animals not named Gabumon.
SELECT * from animals WHERE name != 'Gabumon';
-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;


-- Delete all animals born after Jan 1st, 2022.
DELETE from animals WHERE date_of_birth > '%2022-01-01';
-- Create a savepoint for the transaction.
SAVEPOINT sp1;
-- Update all animals' weight to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1;
-- Rollback to the savepoint
ROLLBACK TO sp1;
-- Update all animals' weights that are negative to be their weight multiplied by -1.
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 1;
-- How many animals are there?
SELECT count(*) FROM animals;
-- How many animals have never tried to escape?
SELECT * from animals WHERE escape_attempts = 0;
SELECT count(*) from animals WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT name, escape_attempts FROM animals where escape_attempts = (SELECT MAX(escape_attempts) FROM animals);
-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT name, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY name;

-- Remove column species
ALTER TABLE animals DROP COLUMN species;
-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals ADD species_id BIGINT;
ALTER TABLE animals
ADD CONSTRAINT FK_species
FOREIGN KEY (species_id) REFERENCES species(id) 
-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals ADD owner_id BIGINT;
ALTER TABLE animals
ADD CONSTRAINT FK_owner
FOREIGN KEY (owner_id) REFERENCES owners(id); 

-- Sam Smith owns Agumon.
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
-- Jennifer Orwell owns Gabumon and Pikachu.
UPDATE animals SET owner_id = 2 WHERE name = 'Gabumon' OR name = 'Pikachu';
-- Bob owns Devimon and Plantmon.
UPDATE animals SET owner_id = 3 WHERE name = 'Devimon' OR name = 'Plantmon';
-- Melody Pond owns Charmander, Squirtle, and Blossom.
UPDATE animals SET owner_id = 4 WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';
-- Dean Winchester owns Angemon and Boarmon.
UPDATE animals SET owner_id = 5 WHERE name = 'Angemon' OR name = 'Boarmon';

-- What animals belong to Melody Pond?
SELECT name, full_name FROM animals a JOIN owners o ON o.id = a.owner_id WHERE o.full_name = 'Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.name, s.name FROM animals a JOIN species s ON s.id = a.species_id WHERE s.name = 'Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT name, full_name FROM animals a JOIN owners o ON o.id = a.owner_id 
UNION ALL SELECT name, full_name FROM owners o LEFT JOIN animals a ON o.id = a.owner_id WHERE a.name IS NULL;
-- How many animals are there per species?
SELECT s.name, count(*) FROM animals a JOIN species s ON s.id = a.species_id GROUP BY s.name;
-- List all Digimon owned by Jennifer Orwell.
SELECT name, species_id FROM animals a JOIN owners o ON o.id = a.owner_id WHERE (SELECT o.full_name = 'Jennifer Orwell' WHERE a.species_id = 2);
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT name, escape_attempts, full_name FROM animals a JOIN owners o ON o.id = a.owner_id WHERE (SELECT o.full_name = 'Dean Winchester' WHERE a.escape_attempts = 0);
-- Who owns the most animals?
SELECT a.owner_id, o.full_name, COUNT(a.owner_id) AS appeared 
FROM animals a 
JOIN owners o ON o.id = a.owner_id 
GROUP BY a.owner_id, o.full_name 
ORDER BY appeared DESC 
LIMIT 1;


-- Who was the last animal seen by William Tatcher?
SELECT v.vet_id, v.animal_id, name, v.visit_date from visits v
JOIN animals a ON a.id = v.animal_id
WHERE v.vet_id = 1 ORDER BY visit_date DESC
LIMIT 1;
-- How many different animals did Stephanie Mendez see?
SELECT DISTINCT count(animal_id) FROM visits
WHERE vet_id = 3;
-- List all vets and their specialties, including vets with no specialties.
SELECT vt.id, species_id, name, age, date_of_graduation FROM specialization sp JOIN vets vt ON sp.vet_id = vt.id
UNION ALL SELECT vt.id, species_id, name, age, date_of_graduation FROM vets vt LEFT JOIN specialization sp ON vt.id = sp.vet_id WHERE sp.species_id IS NULL;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT vet_id, animal_id, visit_date, name
FROM visits vs
JOIN animals a ON a.id = vs.animal_id
WHERE vet_id = 3 
AND visit_date BETWEEN '2020-04-01' AND '2020-08-30';
-- What animal has the most visits to vets?
SELECT COUNT(vs.animal_id) AS appeared, vs.animal_id, a.name
FROM visits vs
JOIN animals a ON a.id = vs.animal_id
GROUP BY vs.animal_id, a.name
ORDER BY appeared DESC
LIMIT 1;
-- Who was Maisy Smith's first visit?
SELECT vet_id, animal_id, visit_date, a.name AS animal_name, vt.name As vet_name
FROM visits vs
JOIN animals a ON a.id = vs.animal_id
JOIN vets vt ON vt.id = vs.vet_id
WHERE vet_id = 2
ORDER BY visit_date ASC
LIMIT 1;
-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT vet_id, animal_id, visit_date, a.name AS animal_name, vt.name As vet_name
FROM visits vs
JOIN animals a ON a.id = vs.animal_id
JOIN vets vt ON vt.id = vs.vet_id
ORDER BY visit_date ASC
LIMIT 1;
-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vt.id, vt.name, count(vs.visit_date)
FROM vets vt
JOIN visits vs ON vt.id = vs.vet_id
LEFT JOIN specialization sp ON vt.id = sp.vet_id WHERE sp.species_id IS NULL
GROUP BY vt.id, vt.name;
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT vt.id, vt.name, a.species_id, species.name AS species_name
FROM vets vt
JOIN visits vs ON vt.id = vs.vet_id
JOIN animals a ON vs.animal_id = a.id
JOIN species  ON a.species_id = species.id
LEFT JOIN specialization sp ON vt.id = sp.vet_id WHERE sp.species_id IS NULL
ORDER BY species_id DESC
LIMIT 1;


--- performance audit queries...
ALTER TABLE owners ADD COLUMN email VARCHAR(120);


