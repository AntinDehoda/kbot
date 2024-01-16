VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETARCH=amd64
TARGETOS=linux
APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=ghcr.io/antindehoda
REPO=github.com/AntinDehoda/kbot/cmd.appVersion

format:
	gofmt -s -w ./
lint:
	golint
test:
	go test -v
get:
	go get
remove:
	rm -rf kbot
build:  format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="${REPO}=${VERSION}
image: 
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} --build-arg TARGETARCH=${TARGETARCH} --build-arg TARGETOS=${TARGETOS}
push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
macos: 
	TARGETARCH=darwin TARGETOS=amd64 \
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} --build-arg TARGETARCH=${TARGETARCH} --build-arg TARGETOS=${TARGETOS}
linux: 
	TARGETARCH=linux TARGETOS=amd64 \
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} --build-arg TARGETARCH=${TARGETARCH} --build-arg TARGETOS=${TARGETOS}
arm: 
	TARGETARCH=linux TARGETOS=arm \
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} --build-arg TARGETARCH=${TARGETARCH} --build-arg TARGETOS=${TARGETOS}
windows: 
	TARGETARCH=windows TARGETOS=amd64 \
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} --build-arg TARGETARCH=${TARGETARCH} --build-arg TARGETOS=${TARGETOS}	
clean: 
	rm -rf kbot; \
	IMG=$$(docker images -q | head -n 1); \
	if [ -n "$${IMG}" ]; then  docker rmi -f $${IMG}; fi

%::
	@true
