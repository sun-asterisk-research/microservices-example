FROM node:16-alpine as builder

WORKDIR /src

RUN apk add --no-cache git

COPY package.json yarn.lock ./
RUN yarn install --production=false --frozen-lockfile

COPY . .

RUN yarn build

FROM node:16-alpine

WORKDIR /src

RUN apk add --no-cache git

COPY package.json yarn.lock ./
RUN yarn install --production=true --frozen-lockfile

COPY --from=builder /src/dist dist

CMD ["yarn", "start"]
