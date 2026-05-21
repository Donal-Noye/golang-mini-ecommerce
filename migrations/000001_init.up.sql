CREATE TABLE users (
   id BIGSERIAL PRIMARY KEY,

   email VARCHAR(255) UNIQUE NOT NULL,
   password_hash TEXT NOT NULL,

   first_name VARCHAR(100),
   last_name VARCHAR(100),

   created_at TIMESTAMP NOT NULL DEFAULT NOW(),
   updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);