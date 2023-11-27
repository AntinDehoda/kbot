VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=antinonimus
TARGETARCH=$(shell dpkg --print-architecture)

format:
	gofmt -s -w ./
lint:
	golint
test:
	go test -v

get:
	go get
build:  format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/AntinDehoda/kbot/cmd.appVersion=${VERSION}
image:   format get
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
clean:
	rm -rf kbot

%::
	@true