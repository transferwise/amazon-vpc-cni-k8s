# Copyright 2014-2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#       http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.
#

# Use := syntax here to not evaluate each time lol
time_label := $(shell date -u +%Y%m%d-%H%M%SZ)
version = dev-${time_label}-${USER}

docker_repo = docker-local-artifacts.transferwise.com
docker_image_name = transferwise/amazon-k8s-cni
docker_tag = ${docker_repo}/${docker_image_name}:${version}

release: docker-login clean resources dependencies binaries docker-image docker-push

docker-login:
	docker login ${docker_repo}

docker-image:
	docker build ./build --tag=${docker_tag}

docker-push:
	docker push ${docker_tag}

create-build-folder:
	mkdir -p ./build

clean:
	rm -rf ./build
	go clean -cache

dependencies:
	dep ensure

binaries: create-build-folder
	export GOOS='linux'; \
	export GOARCH='amd64'; \
	go build -o ./build/aws-k8s-agent main.go; \
	go build -o ./build/aws-cni	plugins/routed-eni/cni.go; \
	go build -o ./build/verify-aws verify-aws.go; \
	go build -o ./build/verify-network verify-network.go;

resources: create-build-folder
	cp \
	Dockerfile \
	misc/aws.conf \
	scripts/aws-cni-support.sh \
	scripts/install-aws.sh \
	build/

# warning: here be AWS API calls!
unit-test:
	go test -v -cover -race -timeout 150s ./pkg/awsutils/...
	go test -v -cover -race -timeout 10s ./plugins/routed-eni/...
	go test -v -cover -race -timeout 10s ./plugins/routed-eni/driver
	go test -v -cover -race -timeout 10s ./pkg/k8sapi/...
	go test -v -cover -race -timeout 10s ./pkg/networkutils/...
	go test -v -cover -race -timeout 10s ./ipamd/...

lint:
	golint pkg/awsutils/*.go
	golint plugins/routed-eni/*.go
	golint plugins/routed-eni/driver/*.go
	golint pkg/k8sapi/*.go
	golint pkg/networkutils/*.go
	golint ipamd/*.go
	golint ipamd/*/*.go

vet:
	go tool vet ./pkg/awsutils
	go tool vet ./plugins/routed-eni
	go tool vet ./pkg/k8sapi
	go tool vet ./pkg/networkutils
