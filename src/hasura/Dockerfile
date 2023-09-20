FROM hasura/graphql-engine:v2.33.3.cli-migrations-v3

WORKDIR /hasura

COPY . .

CMD graphql-engine \
  --metadata-database-url $HASURA_GRAPHQL_METADATA_DATABASE_URL \
  serve \
  --enable-console
