FROM rust:1.67-buster as builder

WORKDIR /src

RUN apt update && apt install musl-dev pkg-config libssl-dev unzip -y
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.20.3/protoc-3.20.3-linux-x86_64.zip \
  && unzip protoc-3.20.3-linux-x86_64.zip -d /usr \
  && rm -rf protoc-3.20.3-linux-x86_64.zip

COPY Cargo.lock Cargo.toml ./
RUN mkdir src && echo 'fn main() {}' > src/main.rs
RUN cargo fetch
RUN cargo build --release && rm -rf src

COPY . .

RUN cargo build -r -p account-subgraph

FROM debian:buster

RUN apt-get update && apt-get install tzdata libssl-dev -y
RUN adduser \
  --disabled-password \
  --gecos "" \
  --home "/nonexistent" \
  --shell "/sbin/nologin" \
  --no-create-home \
  --uid 10001 \
  deploy

USER deploy:deploy

WORKDIR /src

COPY --from=builder --chown=deploy:deploy /src/target/release/account-subgraph ./

EXPOSE 8000

ENTRYPOINT [ "/src/account-subgraph" ]
