FROM hasura/graphql-engine:v2.33.3.cli-migrations-v3

WORKDIR /hasura

ENV HASURA_GRAPHQL_MIGRATIONS_SERVER_TIMEOUT=60 \
  HASURA_GRAPHQL_MIGRATIONS_DIR=/hasura/migrations \
  HASURA_GRAPHQL_METADATA_DIR=/hasura/metadata

COPY . .

CMD graphql-engine \
  --metadata-database-url $HASURA_GRAPHQL_METADATA_DATABASE_URL \
  serve \
  --enable-console
