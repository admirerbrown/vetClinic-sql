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
