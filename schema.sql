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

CREATE TABLE vets (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(150),
    Age INT NOT NULL,
    date_of_graduation DATE NOT NULL);

CREATE TABLE specialization (
    id BIGSERIAL PRIMARY KEY,
    vet_id INT NOT NULL,
    species_id INT NOT NULL,
    FOREIGN KEY (species_id) REFERENCES species(id)
    ON DELETE CASCADE,
    FOREIGN KEY (vet_id) REFERENCES vets(id)
    ON DELETE CASCADE);

    CREATE TABLE visits (
    id BIGSERIAL PRIMARY KEY,
    vet_id INT NOT NULL,
    animal_id INT NOT NULL,
    visit_date DATE NOT NULL,
    FOREIGN KEY (vet_id) REFERENCES vets(id)
    ON DELETE CASCADE,
    FOREIGN KEY (animal_id) REFERENCES animals(id)
    ON DELETE CASCADE);

