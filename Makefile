all: client server

TAG ?= 0.1
REPO ?= poorunga

client: client.go
	CGO_ENABLED=0 go build -a -installsuffix cgo --ldflags '-w' ./client.go

server: server.go
	CGO_ENABLED=0 go build -a -installsuffix cgo --ldflags '-w' ./server.go

buildx:
	docker buildx build --push --platform linux/amd64,linux/arm64 -t $(REPO)/websocket_echo:$(TAG) -f Dockerfile .

clean:
	rm -f client server
