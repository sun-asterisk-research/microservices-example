CREATE TABLE "public"."users" (
    "id" serial NOT NULL,
    "fullname" varchar(255) NOT NULL,
    "username" varchar(30) NOT NULL,
    "birthday" timestamptz,
    "created_at" timestamptz NOT NULL DEFAULT now(),
    "updated_at" Timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY ("id") ,
    UNIQUE ("username")
);
