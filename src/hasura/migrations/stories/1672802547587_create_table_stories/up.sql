-- Create enum for status field
CREATE TYPE content_status AS ENUM ('public', 'unlisted', 'draft');

-- Create table "stories"
CREATE TABLE "public"."stories" (
  "id" SERIAL NOT NULL,
  "title" VARCHAR(255) NOT NULL,
  "contents" TEXT NOT NULL,
  "hashid" VARCHAR(20) NOT NULL,
  "status" content_status NOT NULL DEFAULT 'draft',
  "user_id" INTEGER NOT NULL,
  "preview_image" VARCHAR(255),
  "preview_content" VARCHAR(500),
  "views_count" INTEGER DEFAULT 0,
  "published_at" TIMESTAMPTZ,
  "created_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
  "updated_at" TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY ("id"),
  UNIQUE ("hashid")
);

-- Initialize indexes
CREATE INDEX "stories_user_id_index" ON "public"."stories" ("user_id");
CREATE INDEX "stories_status_index" ON "public"."stories" ("status");
CREATE INDEX "stories_created_at_index" ON "public"."stories" ("created_at" DESC);
CREATE INDEX "stories_published_at_index" ON "public"."stories" ("published_at" DESC);
