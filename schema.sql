/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
   id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(200),
  date_of_birth DATE,
  escape_attempts INT,
  neutered BOOLEAN,
  weight_kg DECIMAL
);

ALTER TABLE animals ADD species VARCHAR(200);

-- multiple tables

-- Create table owners
CREATE TABLE owners (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  full_name TEXT,
  age INTEGER
);

-- Create table species
CREATE TABLE species (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);

-- Modify animals table
CREATE TABLE animals_backup (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  species_id INTEGER,
  owner_id INTEGER,
  FOREIGN KEY (species_id) REFERENCES species(id),
  FOREIGN KEY (owner_id) REFERENCES owners(id)
);

-- Copy existing data to backup table
INSERT INTO animals_backup SELECT * FROM animals;

-- Drop old animals table
DROP TABLE animals;

-- new animals table
CREATE TABLE animals (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  species_id INTEGER,
  owner_id INTEGER,
  FOREIGN KEY (species_id) REFERENCES species(id),
  FOREIGN KEY (owner_id) REFERENCES owners(id)
);

-- Copy data back new animals table
INSERT INTO animals SELECT * FROM animals_backup;

-- Drop backup table
DROP TABLE animals_backup;
