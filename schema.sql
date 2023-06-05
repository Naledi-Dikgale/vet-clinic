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