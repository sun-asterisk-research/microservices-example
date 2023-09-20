FROM node:16-alpine as builder

WORKDIR /src

COPY package.json yarn.lock ./
RUN yarn install --production=false --frozen-lockfile

COPY . .

RUN yarn codegen && yarn build

FROM node:16-alpine

WORKDIR /src

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY --from=builder /src/build build
COPY --from=builder /src/graphql/generated graphql/generated

CMD ["yarn", "start"]
