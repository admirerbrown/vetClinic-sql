/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Agumon', date '2020-02-03', 0, TRUE, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Gabumon', date '2018-11-15', 2, TRUE, 8.0);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Pikachu', date '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Devimon', date '2017-05-12', 5, TRUE, 11.0);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', date '2020-02-08', 0, FALSE, -11.0);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', date '2021-11-15', 2, TRUE, -5.7);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', date '1993-04-02', 3, FALSE, -12.13);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', date '2005-06-12', 1, TRUE, -45.0);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', date '2005-06-07', 7, TRUE, 20.4);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', date '1998-10-13', 3, TRUE, 17.0);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', date '2022-05-14', 4, TRUE, 22.0);


INSERT INTO species (name) VALUES ('Pokemon');
INSERT INTO species (name) VALUES ('Digimon');

INSERT INTO owners (Full_name, Age) VALUES ('Sam Smith', 34);
INSERT INTO owners (Full_name, Age) VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (Full_name, Age) VALUES ('Bob', 45);
INSERT INTO owners (Full_name, Age) VALUES ('Melody Pond', 77);
INSERT INTO owners (Full_name, Age) VALUES ('Dean Winchester', 14);
INSERT INTO owners (Full_name, Age) VALUES ('Jodie Whittaker', 38);


INSERT INTO vets (name, Age, date_of_graduation) VALUES ('William Tatcher', 45, date '2000-04-23');
INSERT INTO vets (name, Age, date_of_graduation) VALUES ('Maisy Smith', 26, date '2019-01-17');
INSERT INTO vets (name, Age, date_of_graduation) VALUES ('Stephanie Mendez', 64, date '1981-05-04');
INSERT INTO vets (name, Age, date_of_graduation) VALUES ('Jack Harkness', 38, date '2008-06-08');


INSERT INTO specialization (vet_id, species_id) VALUES (1, 1);
INSERT INTO specialization (vet_id, species_id) VALUES (3, 2);
INSERT INTO specialization (vet_id, species_id) VALUES (3, 1);
INSERT INTO specialization (vet_id, species_id) VALUES (4, 2);

INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (1, 1, date '2020-05-24');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (3, 1, date '2020-07-22');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (4, 2, date '2021-02-02');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (2, 3, date '2020-01-05');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (2, 3, date '2020-03-08');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (2, 3, date '2020-05-14');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (3, 4, date '2021-05-04');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (4, 12, date '2021-02-24');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (2, 13, date '2019-12-21');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (1, 13, date '2020-08-10');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (2, 13, date '2021-04-07');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (3, 14, date '2019-09-29');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (4, 15, date '2020-10-03');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (4, 15, date '2020-11-04');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (2, 16, date '2019-01-24');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (2, 16, date '2019-05-15');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (2, 16, date '2020-02-27');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (2, 16, date '2020-08-03');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (3, 17, date '2020-05-24');
INSERT INTO visits (vet_id, animal_id, visit_date) VALUES (1, 17, date '2021-01-11');

-- perfomance audit...

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';






















