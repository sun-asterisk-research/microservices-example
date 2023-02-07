FROM golang:1.20-alpine

WORKDIR /src

# cli for health checks
RUN GRPC_HEALTH_PROBE_VERSION=v0.4.15 && \
  wget -qO/bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
  chmod +x /bin/grpc_health_probe

# install go-watch
RUN go install github.com/mitranim/gow@latest

# install dependencies
COPY go.mod go.sum ./
RUN go mod download

COPY . .

CMD [ "gow", "run", "main.go" ]
