/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
   id SERIAL NOT NULL,
  name VARCHAR(200),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL
);

ALTER TABLE animals ADD species VARCHAR(200);

-- multiple tables

-- Create table owners
CREATE TABLE owners(
  id SERIAL NOT NULL,
  full_name VARCHAR(200),
  age INT,
  PRIMARY KEY(id)
);

-- Create table species
CREATE TABLE species(
  id SERIAL NOT NULL,
  name VARCHAR(200),
  PRIMARY KEY(id)
);

-- modify
ALTER TABLE animals DROP species;

ALTER TABLE animals ADD species_id INT REFERENCES species(id);

ALTER TABLE animals ADD owner_id INT REFERENCES owners(id);