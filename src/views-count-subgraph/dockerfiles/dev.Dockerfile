FROM node:16-alpine

WORKDIR /src

RUN apk add --no-cache git

COPY package.json yarn.lock ./
RUN yarn install --production=false --frozen-lockfile

COPY . .

CMD ["yarn", "dev"]
