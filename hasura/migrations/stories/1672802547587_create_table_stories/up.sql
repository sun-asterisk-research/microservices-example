-- Create table "stories"
CREATE TABLE "public"."stories" (
    "id" SERIAL NOT NULL,
    "title" VARCHAR(255) NOT NULL,
    "body" TEXT NOT NULL,
    "hashid" VARCHAR(20) NOT NULL,
    "user_id" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    "updated_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY ("id"),
    UNIQUE ("hashid")
);

-- Initialize indexes
CREATE INDEX "stories_user_id_index" ON "public"."stories" ("user_id");
CREATE INDEX "stories_created_at_index" ON "public"."stories" ("created_at" DESC);
