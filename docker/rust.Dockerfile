FROM ghcr.io/kimyvgy/rustdev:1.71-bullseye

WORKDIR /src

RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.20.3/protoc-3.20.3-linux-x86_64.zip \
  && unzip protoc-3.20.3-linux-x86_64.zip -d /usr \
  && rm -rf protoc-3.20.3-linux-x86_64.zip
