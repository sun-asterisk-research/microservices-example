CREATE TABLE "public"."accounts" (
  "id" serial NOT NULL,
  "fullname" varchar(255) NOT NULL,
  "username" varchar(30) NOT NULL,
  "email" varchar(255) NOT NULL,
  "password_hash" varchar(72),
  "avatar" VARCHAR(41),
  "birthday" timestamptz,
  "email_verified_at" timestamptz,
  "created_at" timestamptz NOT NULL DEFAULT now(),
  "updated_at" Timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY ("id") ,
  UNIQUE ("username"),
  UNIQUE ("email")
);

CREATE INDEX "accounts_email_verified_at" ON "public"."accounts" ("email_verified_at");
