.PHONY: build
build:
	mkdir -p output
	GOOS=linux GOARCH=arm64 go build -o output/jetson-devicequery main.go

.PHONY: setup-multiarch
setup-multiarch:
	docker buildx create --name multiarch --use

.PHONY: build-and-push-multiarch
build-and-push-multiarch: build
	docker buildx use multiarch
	docker buildx build \
		--platform linux/arm64/v8 \
		-t ghcr.io/threadproc/jetson-devicequery:latest \
		--push .

.PHONY: build-only
build-only: build
	docker buildx use multiarch
	docker buildx build \
		--platform linux/arm64/v8 \
		-t ghcr.io/threadproc/jetson-devicequery:latest \
		.