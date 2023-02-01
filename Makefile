#!/usr/bin/make

PROTO_SRC_DIR := ./api/proto

.DEFAULT_GOAL := help

help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo "\n  Allowed for overriding next properties:\n\n\
	    Usage example:\n\
	        make build"

build: ## Build app
	go build cmd/server/main.go

run: ## Run app
	go run cmd/server/main.go

pb: ## Generate protobuf files
	protoc --proto_path="$(PROTO_SRC_DIR)" --go-grpc_out=. "$(PROTO_SRC_DIR)"/adder.proto

# protoc -I="$(PROTO_SRC_DIR)" --go_out=./pkg/api/ "$(PROTO_SRC_DIR)"/adder.proto