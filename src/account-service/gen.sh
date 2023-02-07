#!/bin/bash

proto_path=../../proto
output_dir=./pb
go_path=$(go env GOPATH)

protoc account.proto \
  --proto_path=$proto_path \
  --proto_path=$go_path/src \
  --go_out=$output_dir \
  --go_opt=paths=source_relative \
  --go-grpc_out=$output_dir \
  --go-grpc_opt=paths=source_relative \
  --govalidators_out=.
