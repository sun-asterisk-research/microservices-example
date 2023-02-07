FROM golang:1.20-alpine as builder

WORKDIR /src

# install dependencies
COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Debuging with Skaffold: `skaffold debug` passes
# See: https://skaffold.dev/docs/workflows/debug
ARG SKAFFOLD_GO_GCFLAGS
RUN go build -gcflags="${SKAFFOLD_GO_GCFLAGS}" -o /account_service main.go


FROM alpine:3.17 as without-grpc-health-probe-bin
RUN apk add --no-cache ca-certificates

WORKDIR /src
COPY --from=builder /account_service /src/account_service

# Define GOTRACEBACK to mark this container as using the Go language runtime
# See: https://skaffold.dev/docs/workflows/debug/#go-runtime-go
ENV GOTRACEBACK=single

EXPOSE 50051
ENTRYPOINT [ "/src/account_service" ]

FROM without-grpc-health-probe-bin
# renovate: datasource=github-releases depName=grpc-ecosystem/grpc-health-probe
RUN GRPC_HEALTH_PROBE_VERSION=v0.4.15 && \
  wget -qO/bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
  chmod +x /bin/grpc_health_probe
