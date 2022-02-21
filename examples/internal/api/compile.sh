#!/usr/bin/env bash

# See also
#  https://github.com/grpc/grpc-go/tree/master/examples

# Most of the below calls are from https://github.com/grpc-ecosystem/grpc-gateway

# generate *pb.go
protoc -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway \
  --go_out=plugins=grpc:. \
  helloworld/helloworld.proto

# generate *pb.gw.go
protoc -I/usr/local/include -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway \
  --grpc-gateway_out=logtostderr=true:. \
  helloworld/helloworld.proto

# generate *.swagger.json
protoc -I/usr/local/include -I. \
  -I$GOPATH/src \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis \
  -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway \
  --swagger_out=logtostderr=true:. \
  helloworld/helloworld.proto && \
  cp helloworld/helloworld.swagger.json /tmp/go-swaggerui/swagger.json
