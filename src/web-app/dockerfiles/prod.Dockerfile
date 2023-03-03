FROM node:16-alpine as builder

WORKDIR /src

COPY package.json yarn.lock ./
RUN yarn install --production=false --frozen-lockfile

COPY . .

RUN yarn build

FROM node:16-alpine

WORKDIR /src

COPY package.json yarn.lock ./
RUN yarn install --production=true --frozen-lockfile

COPY --from=builder /src/build build

CMD ["yarn", "start"]
