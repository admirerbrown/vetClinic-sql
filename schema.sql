/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INTEGER NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL,
    species VARCHAR(100) NOT NULL,

);

CREATE TABLE owners (
    id BIGSERIAL PRIMARY KEY,
    Full_name VARCHAR(150) NOT NULL,
    Age INT NOT NULL
);

CREATE TABLE species (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(150)
);
