CREATE TABLE "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "users" ("id" integer NOT NULL PRIMARY KEY, "name" varchar DEFAULT NULL, "email" varchar DEFAULT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "password_digest" varchar DEFAULT NULL, "remember_digest" varchar DEFAULT NULL, "admin" boolean DEFAULT 'f', "activation_digest" varchar, "activated" boolean DEFAULT 'f', "activated_at" datetime);
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
INSERT INTO "schema_migrations" (version) VALUES
('20181015151734'),
('20181028130453'),
('20181112150725'),
('20181210175418'),
('20181220142543'),
('20181222160456');


