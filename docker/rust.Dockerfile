FROM rust:1.67-buster

WORKDIR /src

RUN apt update && apt install musl-dev pkg-config libssl-dev unzip -y
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.20.3/protoc-3.20.3-linux-x86_64.zip \
  && unzip protoc-3.20.3-linux-x86_64.zip -d /usr \
  && rm -rf protoc-3.20.3-linux-x86_64.zip

RUN cargo install cargo-watch
