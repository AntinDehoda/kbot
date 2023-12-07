VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
APP=$(shell basename $(shell git remote get-url origin))
#REGISTRY=us-central1-docker.pkg.dev-docker.pkg.dev/buoyant-climate-272814/devops-cours-docker-repo
REGISTRY=antinonimus
TARGETARCH=$(shell dpkg --print-architecture)
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
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -o bin/app-amd64-linux  kbot -ldflags "-X="${REPO}=${VERSION}
arm:
	CGO_ENABLED=0 GOOS=linux GOARCH=arm go build -v -o kbot -ldflags "-X="${REPO}=${VERSION}
macos:
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -v -o bin/app-amd64-darwin kbot -ldflags "-X="${REPO}=${VERSION}
windows:
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -v -o bin/app-amd64.exe kbot -ldflags "-X="${REPO}=${VERSION}		
clean: 
	docker rmi <IMAGE_TAG>

%::
	@true
